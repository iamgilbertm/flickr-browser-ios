//
//  AppDelegate+RootViewController.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import UIKit

extension AppDelegate {
  func setRootViewControllerToDashboard() {
    let dashboardController = R.storyboard.dashboard.dashboardController()!
    dashboardController.viewModel = DashboardControllerViewModel()
    
    window?.setRootViewControllerAnimated(dashboardController)
  }
}
