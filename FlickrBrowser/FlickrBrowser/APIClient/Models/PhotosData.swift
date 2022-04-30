//
//  Photo.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import Foundation

struct PhotosData {
  let photos: Photos
  let stat: String
}

// MARK: - Codable

extension PhotosData: Codable {
  enum CodingKeys: String, CodingKey {
    case photos, stat
  }
}
