//
//  UIImageView.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import Alamofire
import AlamofireImage
import UIKit

extension UIImageView {
  func setImageWithURL(
    _ url: URL?,
    filter: ImageFilter? = nil,
    placeholder: UIImage? = nil,
    runImageTransitionIfCached: Bool = false,
    completion: VoidResult? = nil
  ) {
    guard let url = url else {
      image = placeholder ?? image
      return
    }
    
    af.setImage(
      withURL: url,
      placeholderImage: placeholder,
      filter: filter,
      imageTransition: .crossDissolve(0.3),
      runImageTransitionIfCached: runImageTransitionIfCached
    ) { _ in
      completion?()
    }
  }
}
