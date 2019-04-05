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
  func login(loginId: String, password: String, completion: @escaping (ApiResult<UserModel, ErrorModel>) -> Void)
  func getMe(completion: @escaping (ApiResult<UserModel, ErrorModel>) -> Void)
}

final class UsersService: BaseService, UsersServiceProtocol {
  override var servicePathComponent: String { return "users" }
  
  func login(loginId: String,
             password: String,
             completion: @escaping (ApiResult<UserModel, ErrorModel>) -> Void) {
    
    let parameters: Parameters = ["login_id": loginId, "password": password]
    let dataRequest = request(methodPathComponent: "users/login",
                              method: .post,
                              headers: nil,
                              parameters: parameters,
                              encoding: JSONEncoding.default)
    
    dataRequest.responseData { (res) in
      guard let headers = res.response?.allHeaderFields as? HTTPHeaders,
          let resData = res.data else { return }
      
      self.saveCookies(from: headers)
      
      do {
        let model = try JSONDecoder().decode(UserModel.self, from: resData)
        completion(.success(model))
      } catch {
        let model = try! JSONDecoder().decode(ErrorModel.self, from: resData)
        completion(.failure(model))
      }
    }
  }
  
  func getMe(completion: @escaping (ApiResult<UserModel, ErrorModel>) -> Void) {
    self.serializableAuthorizedRequest(methodPathComponent: "users/me",
                                       method: .get,
                                       parameters: nil,
                                       completion: completion)
  }
}
