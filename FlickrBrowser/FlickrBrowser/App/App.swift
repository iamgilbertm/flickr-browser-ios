//
//  App.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import Foundation
import UIKit

class App {
  static let shared = App()
  
  private(set) var api: APIClient!
  
  func bootstrap(
    with application: UIApplication,
    launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) {
    api = APIClient(apiKey: "96358825614a5d3b1a1c3fd87fca2b47")
  }
}
