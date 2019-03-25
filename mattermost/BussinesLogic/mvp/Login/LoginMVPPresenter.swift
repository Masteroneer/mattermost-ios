//
//  LoginPresenter.swift
//  mattermost
//
//  Created by Вадим Салмин on 18.03.2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class LoginMVPPresenter: BasePresenter, LoginPresenterProtocol {
  private var usersService: UsersServiceProtocol
  
  private var email: String = ""
  private var password: String = ""
  
  required init(baseView: BaseViewPresenterProtocol, baseRouter: BasePresenterRouterProtocol, inputParams: BaseInputParamsProtocol?) {
    usersService = ApiServiceManager.shared.createService(from: UsersService.self)
    super.init(baseView: baseView, baseRouter: baseRouter, inputParams: inputParams)
  }
  
  func onChange(email: String) {
    self.email = email
  }
  
  func onChange(password: String) {
    self.password = password
  }
  
  func onPressLogin() {
    usersService.login(loginId: email, password: password) {
      
    }
  }
}
