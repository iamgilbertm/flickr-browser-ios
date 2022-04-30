//
//  Theme+Font.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import UIKit

extension Theme.font {
  static func regular(ofSize size: CGFloat) -> UIFont {
    return R.font.sfProTextRegular(size: size)!
  }

  static func medium(ofSize size: CGFloat) -> UIFont {
    R.font.sfProTextMedium(size: size)!
  }

  static func heavy(ofSize size: CGFloat) -> UIFont {
    R.font.sfProTextBold(size: size)!
  }
}
