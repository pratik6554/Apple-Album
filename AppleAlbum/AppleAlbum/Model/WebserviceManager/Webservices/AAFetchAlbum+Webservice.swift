//
//  AAFetchAlbum+Webservice.swift
//  AppleAlbum
//
//  Created by Pratik Gandhi on 11/12/17.
//  Copyright © 2017 Pratik Gandhi. All rights reserved.
//

import Foundation

extension AAWebServiceManager {
  
  static func fetchAlbumList(completion: @escaping AACompletionCallback<[AAAlbum]>) {
    let albumURL = URL(string: AAServiceURLInfo.albumeURL)
    guard let URL = albumURL else {
      completion(.failure(nil, AAServiceError.invalidAlbumUrl))
      return
    }

    let urlRequest = URLRequest(url: URL)
    let task =  AAWebServiceManager.shared.session.dataTask(with: urlRequest) { (data, response, error) in
      if error == nil {
        AAWebServiceManager.mapJSONData(data: data, completion: completion)
      } else {
        completion(.failure(nil, error))
      }
    }
    task.resume()
  }

  private static func mapJSONData(data: Data?, completion: @escaping AACompletionCallback<[AAAlbum]>) {
    guard let data = data else {
      completion(.failure(nil, AAServiceError.invalidJSONData))
      return
    }
    do {
      if let dataDict = try JSONSerialization.jsonObject(with: data, options: []) as? JSON,
        let feed = dataDict[AAServerKeys.feed.rawValue] as? JSON,
        let entryList = feed[AAServerKeys.entry.rawValue] as? [JSON] {
        let albumList =  entryList.flatMap { AAAlbum(json: $0) }
        completion(.success(albumList))
      } else {
        completion(.failure(nil, AAServiceError.jsonDataparsingError))
      }
    }
    catch let error {
      completion(.failure(data, error))
    }
  }
}
