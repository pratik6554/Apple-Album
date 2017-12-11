//
//  AAError.swift
//  AppleAlbum
//
//  Created by Pratik Gandhi on 11/12/17.
//  Copyright © 2017 Pratik Gandhi. All rights reserved.
//

import Foundation

enum AAServiceError: Error {
  case invalidJSONData
  case invalidAlbumUrl
  case jsonDataparsingError
}

extension Error {
  func handleError() {

  }
}

