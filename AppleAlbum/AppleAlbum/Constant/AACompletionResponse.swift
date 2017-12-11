//
//  AACompletionResponse.swift
//  AppleAlbum
//
//  Created by Pratik Gandhi on 11/12/17.
//  Copyright © 2017 Pratik Gandhi. All rights reserved.
//

import Foundation

public enum AACompletionResponse {

  case success(AnyObject)
  case failure(Data?, Error?)

  public var isSuccess: Bool {
    switch self {
    case .success:
      return true
    case .failure:
      return false
    }
  }

  public var isFailure: Bool {
    return !isSuccess
  }

  public var value: AnyObject? {
    switch self {
    case .success(let value):
      return value
    case .failure:
      return nil
    }
  }

  public var data: Data? {
    switch self {
    case .success:
      return nil
    case .failure(let data, _):
      return data
    }
  }

  public var error: Error? {
    switch self {
    case .success:
      return nil
    case .failure(_, let error):
      return error
    }
  }
}

