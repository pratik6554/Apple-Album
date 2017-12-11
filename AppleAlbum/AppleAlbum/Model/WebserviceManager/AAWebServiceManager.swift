//
//  AAWebServiceManager.swift
//  AppleAlbum
//
//  Created by Pratik Gandhi on 11/12/17.
//  Copyright © 2017 Pratik Gandhi. All rights reserved.
//

import Foundation

//Singleton class
class AAWebServiceManager {

  static let shared = AAWebServiceManager()
  let session = URLSession.shared
  private init() {}
}


