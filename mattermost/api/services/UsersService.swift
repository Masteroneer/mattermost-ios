//
//  UsersService.swift
//  mattermost
//
//  Created by Вадим on 25/02/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import Alamofire

typealias LoginResponseCompletion = (_ token: String) -> Void

protocol UsersServiceProtocol {
  func login(loginId: String, password: String, completion: @escaping LoginResponseCompletion)
  func getMe()
}

final class UsersService: BaseService, UsersServiceProtocol {
  override var prefix: String { return "users" }
  
  func login(loginId: String, password: String, completion: @escaping LoginResponseCompletion) {
    let parameters: Parameters = ["login_id": loginId, "password": password]
    self.makeRequest(methodPrefix: "login", method: .post, parameters: parameters).responseJSON { (res) in }
  }
  
  func getMe() {
    self.makeRequest(methodPrefix: "me", method: .get, parameters: nil).responseJSON { (res) in
      print(res)
    }
  }
}
