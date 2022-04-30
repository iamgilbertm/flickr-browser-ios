//
//  UIView.swift
//  FlickrBrowser
//
//  Created by Gilbert on 4/30/22.
//

import UIKit

protocol RoundedViewType {
  func roundify(_ customRadius: CGFloat?)
}

extension UIView: RoundedViewType {}

extension RoundedViewType where Self: UIView {
  func roundify(_ customRadius: CGFloat? = nil) {
    clipsToBounds = true
    
    if let customRadius = customRadius {
      layer.cornerRadius = customRadius
    } else {
      let size = min(frame.size.width, frame.size.height)
      layer.cornerRadius = size / 2
    }
  }
}
