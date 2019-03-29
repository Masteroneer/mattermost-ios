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
  func login(loginId: String, password: String) -> ApiResult<UserModel, ErrorModel>
  func getMe() -> ApiResult<UserModel, ErrorModel>
}

final class UsersService: BaseService, UsersServiceProtocol {
  override var servicePathComponent: String { return "users" }
  
  // TODO: - Доделать
  func login(loginId: String, password: String) -> ApiResult<UserModel, ErrorModel> {
    let result = ApiResult<UserModel, ErrorModel>()
    let parameters: Parameters = ["login_id": loginId, "password": password]
    self.request(methodPathComponent: "login", method: .post, parameters: parameters).responseData { (res) in
      guard let headers = res.response?.allHeaderFields as? [String: String],
          let status = res.response?.statusCode,
          let resData = res.data else { return }
      self.saveCookies(from: headers)
      
      if status == 200 {
        let model = try! JSONDecoder().decode(UserModel.self, from: resData)
        result.send(success: model)
      } else {
        let model = try! JSONDecoder().decode(ErrorModel.self, from: resData)
        result.send(error: model)
      }
    }
    return result
  }
  
  func getMe() -> ApiResult<UserModel, ErrorModel> {
    return self.serializableAuthorizedRequest(methodPathComponent: "me", method: .get, parameters: nil)
  }
}
