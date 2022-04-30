//
//  Photos.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import Foundation

struct Photos {
  let page, pages, perPage, total: Int
  let photos: [Photo]
}

// MARK: - Codable

extension Photos: Codable {
  enum CodingKeys: String, CodingKey {
    case page, pages, total
    case perPage = "perpage"
    case photos = "photo"
  }
}
