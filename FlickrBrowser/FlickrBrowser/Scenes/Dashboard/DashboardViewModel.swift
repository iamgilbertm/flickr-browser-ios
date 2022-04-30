//
//  DashboardViewModel.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import Alamofire
import Foundation
import NSObject_Rx
import RxRelay
import RxSwift

protocol DashboardControllerViewModelProtocol {
  var contentState: BehaviorRelay<ContentState> { get }
  var photosObservable: BehaviorRelay<[Photo]> { get }
  
  func search(_ text: String?, forceRefresh: Bool)
}

class DashboardControllerViewModel: DashboardControllerViewModelProtocol {
  private let apiClient: APIClient
  
  let contentState = BehaviorRelay<ContentState>(value: .empty)
  
  private let perPage = 60
  
  private var page: Int {
    guard let photosData = photosData else { return 1 }
    return photosData.photos.page + 1
  }
  
  private var photosData: PhotosData?
  private(set) var photosObservable: BehaviorRelay<[Photo]> = BehaviorRelay(value: [])
  private var photos: [Photo] = []
  
  required init(apiClient: APIClient = App.shared.api) {
    self.apiClient = apiClient
  }
  
  func search(_ text: String?, forceRefresh: Bool) {
    contentState.accept(.loading)
    
    var searchString: String {
      guard let text = text, !text.isEmpty else { return "random" }
      return text
    }
    
    apiClient.search(searchString, page: forceRefresh ? 1 : page, perPage: perPage) { [weak self] photosData in
      guard let self = self else { return }
      self.photosData = photosData
      
      if forceRefresh {
        self.photos = photosData.photos.photos
      } else {
        self.photos += photosData.photos.photos
      }
      
      self.photosObservable.accept(self.photos)
      
      self.contentState.accept(.ready)
    } failure: { [weak self] error in
      self?.contentState.accept(.error(error))
    }
  }
}
