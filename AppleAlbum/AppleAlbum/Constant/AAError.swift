//
//  AAError.swift
//  AppleAlbum
//
//  Created by Pratik Gandhi on 11/12/17.
//  Copyright © 2017 Pratik Gandhi. All rights reserved.
//

import Foundation

enum AAParsingError: Error {
  case missing(String)
  case invalid(String, Any)
}

enum AAServiceResponseError: Error {
  case invalidJSONData
}


