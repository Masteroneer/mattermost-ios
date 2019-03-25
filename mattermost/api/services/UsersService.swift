//
//  UsersService.swift
//  mattermost
//
//  Created by Вадим on 25/02/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import Alamofire

protocol UsersServiceProtocol: BaseServiceProtocol {
  func login(loginId: String, password: String, completion: @escaping () -> Void)
  func getMe(completion: @escaping (UserModel) -> Void)
}

final class UsersService: BaseService, UsersServiceProtocol {
  override var servicePathComponent: String { return "users" }
  
  func login(loginId: String, password: String, completion: @escaping () -> Void) {
    let parameters: Parameters = ["login_id": loginId, "password": password]
    self.request(methodPathComponent: "login", method: .post, parameters: parameters).responseData { (res) in
      guard let headers = res.response?.allHeaderFields as? HTTPHeaders else { return }
      self.saveCookies(from: headers)
      completion()
    }
  }
  
  func getMe(completion: @escaping (UserModel) -> Void) {
//    self.serializableAuthorizedRequest(methodPathComponent: "me", method: .get, parameters: nil, completion: )
  }
}
