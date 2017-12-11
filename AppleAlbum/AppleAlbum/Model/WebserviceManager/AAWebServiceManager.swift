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

  private init() {
  }

  func fetchAlbumList(completion: @escaping ([AAAlbum]) -> Void) {
    let albumURL = URL(string: AAServiceURLInfo.albumeURL)
    //TODO: Handle Error
    //TODO: Check this
    guard let URL = albumURL else {
      print("Wrong url")
      return
    }
    let urlRequest = URLRequest(url: URL)

    let task =  session.dataTask(with: urlRequest) { (data, response, error) in

      if error == nil {
        self.mapJSONData(data: data, completion: completion)
      } else {
        print("Error == \(String(describing: error)) ")
      }
    }
    task.resume()
  }

  func mapJSONData(data: Data?, completion: @escaping ([AAAlbum]) -> Void) {

    guard let data = data else {
      print("Something wrong")
      return
    }

    do {
      if let dataDict = try JSONSerialization.jsonObject(with: data, options: []) as? JSON,
          let feed = dataDict[AAServerKeys.feed.rawValue] as? JSON,
          let entryList = feed[AAServerKeys.entry.rawValue] as? [JSON] {
          let albumList =  entryList.flatMap { AAAlbum(json: $0) }
          completion(albumList)
        }
    }
    catch  {
      print("Error ")
    }
  }

}
