//
//  Photos.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import Foundation

struct Photo {
  let id, owner, secret, server, title: String
  let farm: Int
  let isPublic, isFriend, isFamily: Boolen
}

// MARK: - Codable

extension Photo: Codable {
  enum CodingKeys: String, CodingKey {
    case id, owner, secret, server, farm, title
    case isPublic = "ispublic"
    case isFriend = "isfriend"
    case isFamily = "isfamily"
  }
}

// MARK: - Getters

extension Photo {
  var imageURL: URL? {
    let urlString = String(format: "http://farm%i.static.flickr.com/%@/%@_%@.jpg", farm, server, id, secret)
    return URL(string: urlString)
  }
}
