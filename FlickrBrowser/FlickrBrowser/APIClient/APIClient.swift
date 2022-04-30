//
//  APIClient.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import Foundation

protocol APIClientProtocol: Service {}
  
class APIClient: APIClientProtocol {
  let apiKey: String
  
  required init(apiKey: String) {
    self.apiKey = apiKey
  }
}
