//
//  Search.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import Alamofire
import Foundation

extension APIClient {
  @discardableResult
  func search(
    _ text: String,
    page: Int,
    perPage: Int,
    success: @escaping SingleResult<PhotosData>,
    failure: @escaping ErrorResult
  ) -> DataRequest {
    let parameters: [String : Any] = [
      "method": "flickr.photos.search",
      "api_key": apiKey,
      "text": text,
      "page": page,
      "per_page": perPage,
      "format": "json",
      "nojsoncallback": 1
    ]
    
    debugPrint("iamgilbertm", page)
    
    return AF.request(
      URL(string: "https://api.flickr.com/services/rest/")!,
      method: .get,
      parameters: parameters,
      encoding: URLEncoding.queryString
    ).responseDecodable(of: PhotosData.self) { data in
      switch data.result {
      case .success(let photos):
        success(photos)
      case .failure(let error):
        failure(error)
      }
    }
  }
}
