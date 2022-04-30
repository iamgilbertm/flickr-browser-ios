//
//  NibLoadable.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import PureLayout
import UIKit

protocol NibLoadable where Self: UIView {
  var contentView: UIView! { get }
}

extension NibLoadable {
  func loadNib(named nibName: String? = nil) {
    let nib = nibName ?? String(describing: type(of: self))
    Bundle.main.loadNibNamed(nib, owner: self, options: nil)
    
    addSubview(contentView)
    
    contentView.autoPinEdgesToSuperviewEdges()
  }
}
