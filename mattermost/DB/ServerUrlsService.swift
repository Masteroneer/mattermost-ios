//
//  ServerUrlsService.swift
//  mattermost
//
//  Created by Vadim Salmin on 13/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

protocol ServerUrlsServiceProtocol {
  func addServerUrl(_ url: String)
  func getLastAccessedUrl() -> String?
}

class ServerUrlsService: ServerUrlsServiceProtocol {
  private let key = ""
  
  func addServerUrl(_ url: String) {
    UserDefaults.standard.set(url, forKey: key)
  }
  
  func getLastAccessedUrl() -> String? {
    return UserDefaults.standard.string(forKey: key)
  }
}
