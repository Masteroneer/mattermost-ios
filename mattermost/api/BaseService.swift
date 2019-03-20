//
//  API.swift
//  mattermost
//
//  Created by Вадим on 14/02/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import Alamofire

class BaseService {
  internal var baseUrl: String
  internal var cookies: [HTTPCookie]
  
  internal var prefix: String {
    get { fatalError("Must be implemented") }
  }
  
  init(baseUrl: String, cookies: [HTTPCookie]) {
    self.baseUrl = baseUrl
    self.cookies = cookies
  }
  
  // methodPrefix is a backend server method not a HTTPMethod
  internal func makeRequest(methodPrefix: String, method: HTTPMethod, parameters: Parameters?, headers: HTTPHeaders?) -> DataRequest {
    return Alamofire.request("\(getUrlWithPrefix())/\(methodPrefix)",
                              method: method,
                              parameters: parameters,
                              headers: headers)
  }
  
  internal func getUrlWithPrefix() -> String {
    return "\(baseUrl)/\(prefix)"
  }
}
