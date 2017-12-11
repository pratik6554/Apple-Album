//
//  AAAlbumTableCell.swift
//  AppleAlbum
//
//  Created by Pratik Gandhi on 11/12/17.
//  Copyright © 2017 Pratik Gandhi. All rights reserved.
//

import UIKit

class AAAlbumTableCell: UITableViewCell {

  @IBOutlet weak var albumCoverImageView: UIImageView!
  @IBOutlet weak var albumNameLabel: UILabel!
  @IBOutlet weak var artistNameLabel: UILabel!

  func configure(album :AAAlbum) {
    albumNameLabel.text = album.albumName
    artistNameLabel.text = album.artistName
    if let imageURL = album.imageURL {
      albumCoverImageView.setImageFromCache(withUrl: imageURL)
    }
  }
}
