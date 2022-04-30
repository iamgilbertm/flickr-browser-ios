//
//  Service.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import Foundation

protocol Service: AnyObject {}

extension Service {
  var app: App { App.shared }
}
