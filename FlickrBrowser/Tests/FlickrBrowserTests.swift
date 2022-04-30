//
//  FlickrBrowserTests.swift
//  FlickrBrowserTests
//
//  Created by Gilbert Mendoza on 4/29/22.
//

import XCTest
@testable import FlickrBrowser

class FlickrBrowserTests: XCTestCase {
  override func setUp() {
    super.setUp()
  }
      
  override func tearDown() {
    super.tearDown()
  }
      
  func testSearchPhoto() {
    let exp = expectation(description: "Search image")
    let apiClient = APIClient(apiKey: App.shared.api.apiKey)
    
    let searchImage = apiClient.search("text", page: 1, perPage: 10) { _ in
      exp.fulfill()
    } failure: { error in
      XCTFail(error.localizedDescription)
      exp.fulfill()
    }

    waitForExpectations(timeout: 10, handler: nil)
    
    XCTAssertNotNil(searchImage)
  }
}
