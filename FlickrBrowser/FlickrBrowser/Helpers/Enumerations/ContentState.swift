//
//  ContentState.swift
//  FlickrBrowser
//
//  Created by Gilbert Mendoza on 4/30/22.
//

import Foundation

enum ContentState {
  case empty
  case ready
  case loading
  case error(_ error: Error)
}

extension ContentState: Equatable {
  static func == (lhs: ContentState, rhs: ContentState) -> Bool {
    switch (lhs, rhs) {
    case (.empty, .empty), (.loading, .loading), (.ready, .ready):
      return true
    case (let .error(error1), let .error(error2)):
      return error1.localizedDescription == error2.localizedDescription
    default:
      return false
    }
  }
}
