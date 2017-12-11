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

  func fetchAlbumList() {
    let albumURLString = "https://itunes.apple.com/us/rss/topalbums/limit=2/json"
    let albumURL = URL(string: albumURLString)
    //TODO: Handle Error
    //TODO: Check this
    guard let URL = albumURL else {
      print("Wrong url")
      return
    }
    let urlRequest = URLRequest(url: URL)

   let task =  session.dataTask(with: urlRequest) { (data, response, error) in
      if error != nil {
        print("Error == \(String(describing: error)) ")
      } else {
        print("response = \(String(describing: data))")

        guard let data = data  else {
           print("Something wrong with response data")
           return
        }
        //TODO: handle exceptions
        if let dataDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] {
          print("dataDict = \(String(describing: dataDict))")

          if let dataDict = dataDict,let feed = dataDict["feed"] as? [String :Any] {
            if let entry = feed["entry"]  {
                print("entry \(entry)")
              self.handleResponse(entry: entry)
            }
          }
        }
      }
    }
   task.resume()
  }

  func handleResponse(entry :Any) {

    if let entryList = entry as? NSArray {
        print("entryList count == \(entryList.count)")
    }
  }

  func mapAlbum(entryList :NSArray ) -> [AAAlbum] {

    var albumList :[AAAlbum] = []
    for entry in entryList {

      if let entryDict = entry as? [String :Any] {
        let albumName = entryDict["im:name"]
      }

    }
    return albumList
  }

}
