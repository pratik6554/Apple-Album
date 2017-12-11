//
//  AAAlbum.swift
//  AppleAlbum
//
//  Created by Pratik Gandhi on 11/12/17.
//  Copyright © 2017 Pratik Gandhi. All rights reserved.
//

import Foundation

struct AAAlbum {
  let albumName: String
  var artistName: String?
  var artistPageUrl :String?
  var imageURL: String?

  init(json :JSON) {

    if let albumInfo = json[AAServerKeys.im_name.rawValue] as? JSON {
      albumName = albumInfo[AAServerKeys.label.rawValue] as? String ?? ""
    } else {
     albumName = ""
    }

    if let artist = json[AAServerKeys.im_artist.rawValue] as? JSON {
      if let artistName = artist[AAServerKeys.label.rawValue] as? String {
        self.artistName = artistName
      }

      if let attributes = artist[AAServerKeys.attributes.rawValue] as? JSON,
        let artistPageUrl = attributes[AAServerKeys.href.rawValue] as? String {
        self.artistPageUrl = artistPageUrl
      }
    }

    if let imagesInfo = json[AAServerKeys.im_image.rawValue] as? [JSON],
       let imageInfo = imagesInfo.first,
       let imageURL = imageInfo[AAServerKeys.label.rawValue] as? String {
       self.imageURL = imageURL
    }
  }
}
