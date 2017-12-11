//
//  WCConstant.swift
//  AppleAlbum
//
//  Created by Pratik Gandhi on 11/12/17.
//  Copyright © 2017 Pratik Gandhi. All rights reserved.
//

import Foundation

enum AACellIdentifierType: String {
  case AlbumTableCell  = "AAAlbumTableCell"
}

enum AAServerKeys: String {
  //Album
  case feed = "feed"
  case entry = "entry"
  case im_name = "im:name"
  case label = "label"
  case im_artist = "im:artist"
  case im_image = "im:image"
  case attributes = "attributes"
  case href = "href"
}

enum AAServiceURLInfo {
  static let numberOfAlbumToFetch = 15
  static var albumeURL: String {
    return "https://itunes.apple.com/us/rss/topalbums/limit=\(numberOfAlbumToFetch)/json"
  }
}


