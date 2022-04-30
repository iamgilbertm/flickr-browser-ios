//
//  Control.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import UIKit

class Control: UIControl {
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.prepare()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    prepare()
  }
  
  func prepare() {}
}
