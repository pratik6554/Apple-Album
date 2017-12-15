//
//  UIImageView+Extension.swift
//  AppleAlbum
//
//  Created by Pratik Gandhi on 11/12/17.
//  Copyright © 2017 Pratik Gandhi. All rights reserved.
//

import Foundation
import UIKit

let AAImageCache = NSCache<NSString, UIImage>()

extension UIImageView {

  func setImageFromCache(withUrl urlString : String) {
    let key = (urlString as NSString)
    let url =  URL(string: urlString)
    self.image = nil
    
    if let cachedImage = AAImageCache.object(forKey: key) {
      self.image = cachedImage
      return
    }
    
    guard let requestURL = url else {
      print("Invalid image url")
      return
    }
    
    URLSession.shared.dataTask(with: requestURL, completionHandler: { (data, response, error) in
      if error != nil {
        print(error!)
        return
      }
      
      DispatchQueue.main.async {
        if let data = data, let image = UIImage(data: data) {
          AAImageCache.setObject(image, forKey: key )
          self.image = image
        }
      }
      
    }).resume()
  }
}
