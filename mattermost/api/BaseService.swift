//
//  API.swift
//  mattermost
//
//  Created by Вадим on 14/02/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import Alamofire

enum ApiVersion: String {
  case v4 = "api/v4/"
}

class BaseService {
  internal var baseUrl: String
  internal var version: ApiVersion
  
  internal var prefix: String {
    get { fatalError("Must be implemented") }
  }
  
  required init(baseUrl: String, version: ApiVersion) {
    self.baseUrl = baseUrl
    self.version = version
  }
  
  ///
  /// Request without auth
  /// - parameter methodPrefix: is a backend server method not a HTTPMethod
  ///
  internal func makeRequest(methodPrefix: String, method: HTTPMethod, parameters: Parameters?) -> DataRequest {
    let url = "\(getUrlWithPrefix())/\(methodPrefix)"
    return Alamofire.request(url,
                              method: method,
                              parameters: parameters,
                              encoding: JSONEncoding.default,
                              headers: nil)
  }
  
  
  /// Request with auth cookies, saved with saveCookies method
  /// - parameter methodPrefix: is a backend server method not a HTTPMethod
  internal func makeAuthorizedRequest(methodPrefix: String, method: HTTPMethod, parameters: Parameters?) -> DataRequest {
    var headers: HTTPHeaders = [:]
    return Alamofire.request("\(getUrlWithPrefix())/\(methodPrefix)",
                              method: method,
                              parameters: parameters,
                              headers: headers)
  }

  internal func saveCookies() {
    
  }
  
  internal func getUrlWithPrefix() -> String {
    return "\(baseUrl)/\(version.rawValue)\(prefix)"
  }
}
