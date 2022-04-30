//
//  SearchBar.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import NSObject_Rx
import RxCocoa
import RxSwift
import UIKit

class SearchBar: Control, NibLoadable {
  @IBOutlet var contentView: UIView!
  
  @IBOutlet private var innerContentView: UIView!
  @IBOutlet private var buttonView: UIView!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet private var cancelButton: UIButton!
  
  @IBOutlet private var leftEdgeConstraint: NSLayoutConstraint!
  @IBOutlet private var rightEdgeConstraint: NSLayoutConstraint!
  
  var text = BehaviorRelay<String?>(value: "")

  var showsCancelButton: Bool = true {
    didSet {
      update()
    }
  }
  
  var leftInset: CGFloat {
    get { leftEdgeConstraint.constant }
    set { leftEdgeConstraint.constant = newValue }
  }
  var rightInset: CGFloat {
    get { rightEdgeConstraint.constant }
    set { rightEdgeConstraint.constant = newValue }
  }
  
  var onClear: VoidResult?
  var onCancel: VoidResult?
  
  override func prepare() {
    super.prepare()
    loadNib()
    
    innerContentView.roundify(10)
    innerContentView.backgroundColor = R.color.gray_8E8E93()?.withAlphaComponent(0.24)
    
    textField.delegate = self
    textField.clearButtonMode = .whileEditing
    textField.font = Theme.textStyle.subHeadline
    textField.attributedPlaceholder = NSAttributedString(
      string: S.searchBarLabelPlaceholder(),
      attributes: [NSAttributedString.Key.font: Theme.textStyle.subHeadline]
    )
    
    cancelButton.titleLabel?.font = Theme.textStyle.body
    cancelButton.tintColor = R.color.textDark()
    
    buttonView.addGestureRecognizer(
      UITapGestureRecognizer(target: self, action: #selector(buttonViewTapped(_:)))
    )
    
    update()
    
    setupBindings()
  }
  
  @IBAction
  func buttonViewTapped(_ sender: AnyObject) {
    sendActions(for: .touchUpInside)
  }

  func update() {
    buttonView.isHidden = true
    cancelButton.isHidden = !showsCancelButton
  }
  
  private func setupBindings() {
    textField.rx.text
      .asDriver()
      .debounce(.milliseconds(300))
      .drive(text)
      .disposed(by: rx.disposeBag)
    
    cancelButton.rx.controlEvent(.touchUpInside)
      .subscribe(onNext: { [weak self] _ in
        self?.textField.rx.text.onNext("")
        self?.onCancel?()
      })
      .disposed(by: rx.disposeBag)
  }
}

// MARK: - Responder

extension SearchBar {
  override var canBecomeFirstResponder: Bool {
    return textField.canBecomeFirstResponder
  }
  
  override var canResignFirstResponder: Bool {
    return textField.canResignFirstResponder
  }
  
  override var canBecomeFocused: Bool {
    return textField.canBecomeFocused
  }
  
  override func becomeFirstResponder() -> Bool {
    return textField.becomeFirstResponder()
  }
  
  override func resignFirstResponder() -> Bool {
    return textField.resignFirstResponder()
  }
}

// MARK: - UITextFieldDelegate

extension SearchBar: UITextFieldDelegate {
  func textFieldShouldClear(_ textField: UITextField) -> Bool {
    defer {
      textField.rx.text.onNext("")
      onClear?()
    }
    return true
  }
}
