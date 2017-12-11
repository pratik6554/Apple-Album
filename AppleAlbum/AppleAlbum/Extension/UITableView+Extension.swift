//
//  UITableView+Extension.swift
//  AppleAlbum
//
//  Created by Pratik Gandhi on 11/12/17.
//  Copyright © 2017 Pratik Gandhi. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
  func registerNib(cellIdentifier: AACellIdentifierType) {
    let nib = UINib(nibName: cellIdentifier.rawValue, bundle: Bundle.main)
    register(nib, forCellReuseIdentifier: cellIdentifier.rawValue)
  }
}

