//
//  SVProgressHUD.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import Foundation
import SVProgressHUD

public extension SVProgressHUD {
  static func showWithMask(_ type: SVProgressHUDMaskType = .clear) {
    SVProgressHUD.show()
    SVProgressHUD.setDefaultMaskType(type)
  }
  
  static func dismissAndRemoveMask() {
    SVProgressHUD.dismiss()
    SVProgressHUD.setDefaultMaskType(.none)
  }
  
  static func showDismissableError(with status: String) {
    addHUDNotificationObservers()
    SVProgressHUD.showError(withStatus: status)
    SVProgressHUD.setDefaultMaskType(.clear)
  }
  
  static func showDismissableInfo(with status: String) {
    addHUDNotificationObservers()
    SVProgressHUD.showInfo(withStatus: status)
    SVProgressHUD.setDefaultMaskType(.clear)
  }
  
  private static func addHUDNotificationObservers() {
    let nc = NotificationCenter.default
    nc.addObserver(
      self, selector: #selector(hudTapped(_:)),
      name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent,
      object: nil
    )
    nc.addObserver(
      self, selector: #selector(hudDisappeared(_:)),
      name: NSNotification.Name.SVProgressHUDWillDisappear,
      object: nil
    )
  }
  
  @objc
  private static func hudTapped(_ notification: Notification) {
    SVProgressHUD.dismiss()
    SVProgressHUD.setDefaultMaskType(.none)
  }
  
  @objc
  private static func hudDisappeared(_ notification: Notification) {
    let nc = NotificationCenter.default
    nc.removeObserver(self, name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent, object: nil)
    nc.removeObserver(self, name: NSNotification.Name.SVProgressHUDWillDisappear, object: nil)
    SVProgressHUD.setDefaultMaskType(.none)
  }
}
