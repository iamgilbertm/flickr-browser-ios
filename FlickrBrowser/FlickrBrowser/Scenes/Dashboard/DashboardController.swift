//
//  DashboardController.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import Lightbox
import RxCocoa
import RxSwift
import SVProgressHUD
import UIKit

class DashboardController: UIViewController {
  var viewModel: DashboardControllerViewModelProtocol!
  
  @IBOutlet weak var searchBar: SearchBar!
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    
    viewModel.search("", forceRefresh: true)
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    collectionView.collectionViewLayout.invalidateLayout()
  }
}

// MARK: - View Setups & Bindings
  
extension DashboardController {
  func setupView() {
    setupBindings()
    setupCollectionView()
    setupPhotoSelection()
  }
  
  func setupBindings() {
    viewModel.contentState
      .subscribe(onNext: { [unowned self] state in
        self.handleContentStateChanges(state)
      })
      .disposed(by: rx.disposeBag)
    
    searchBar.textField.rx.controlEvent(.editingDidEnd)
      .subscribe(onNext: { [unowned self] in
        self.viewModel.search(self.searchBar.text.value, forceRefresh: true)
      })
      .disposed(by: rx.disposeBag)
    
    searchBar.onClear = { [unowned self] in
      self.viewModel.search("", forceRefresh: true)
    }
    
    searchBar.onCancel = { [unowned self] in
      self.viewModel.search("", forceRefresh: true)
    }
  }
  
  func setupCollectionView() {
    let nib = UINib(resource: R.nib.photoCell)
    collectionView.register(nib, forCellWithReuseIdentifier: R.nib.photoCell.identifier)

    viewModel.photosObservable
      .bind(to: collectionView
        .rx
        .items(
          cellIdentifier: R.nib.photoCell.identifier,
          cellType: PhotoCell.self
        )
      ) { _, photo, cell in
        cell.configure(with: photo)
      }
      .disposed(by: rx.disposeBag)
  }
  
  func setupPhotoSelection() {
    Observable.of(
      collectionView.rx.modelSelected(Photo.self)
    )
    .merge()
    .subscribe(onNext: { [unowned self] photo in
      self.showPhotoGalleryViewer(photo)
    })
    .disposed(by: rx.disposeBag)
  }
}

// MARK: - Events

private extension DashboardController {
  func handleContentStateChanges(_ state: ContentState) {
    switch state {
    case .empty:
      SVProgressHUD.dismissAndRemoveMask()
    case .loading:
      SVProgressHUD.showWithMask()
    case let .error(e):
      SVProgressHUD.showError(withStatus: e.localizedDescription)
    case .ready:
      SVProgressHUD.dismissAndRemoveMask()
    }
  }
  
  func showPhotoGalleryViewer(_ selectedPhoto: Photo) {
    var images = [LightboxImage]()
    var selectedIndex = 0
    
    viewModel.photosObservable.value.enumerated().forEach { index, photo in
      guard let imageURL = photo.imageURL else { return }
      
      let image = LightboxImage(imageURL: imageURL, text: photo.title)
      images.append(image)
      
      if photo.id == selectedPhoto.id {
        selectedIndex = index
      }
    }
    
    let controller = LightboxController(images: images, startIndex: selectedIndex)
    controller.dynamicBackground = true
    controller.modalPresentationStyle = .fullScreen
    
    present(controller, animated: true)
  }
}

// MARK: UICollectionViewDelegateFlowLayout

extension DashboardController: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    let screenWidth = collectionView.bounds.width
    let scaleFactor = (screenWidth / 3) - 11
    
    return CGSize(width: scaleFactor, height: scaleFactor)
  }
}

// MARK: UIScrollViewDelegate

extension DashboardController: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.bounds.size.height) {
      if viewModel.contentState.value != .loading {
        viewModel.search(searchBar.text.value, forceRefresh: false)
      }
    }
  }
}
