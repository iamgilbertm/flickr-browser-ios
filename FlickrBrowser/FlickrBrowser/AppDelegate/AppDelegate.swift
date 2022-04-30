//
//  AppDelegate.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/29/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    App.shared.bootstrap(with: application, launchOptions: launchOptions)

    window = UIWindow(frame: UIScreen.main.bounds)
    setRootViewControllerToDashboard()
    window?.makeKeyAndVisible()

    return true
  }
}
