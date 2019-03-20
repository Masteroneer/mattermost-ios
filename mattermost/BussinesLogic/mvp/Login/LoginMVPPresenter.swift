//
//  LoginPresenter.swift
//  mattermost
//
//  Created by Вадим Салмин on 18.03.2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class LoginMVPPresenter: BasePresenter, LoginPresenterProtocol {
  private let usersService: UsersServiceProtocol
  
  required init(baseView: BaseViewPresenterProtocol, baseRouter: BasePresenterRouterProtocol, inputParams: BaseInputParamsProtocol?) {
    super.init(baseView: baseView, baseRouter: baseRouter, inputParams: inputParams)
//    usersService = UsersService()
  }
  
  func onChange(email: String) {
    
  }
  
  func onChange(password: String) {
    
  }
  
  func onPressLogin() {
    
  }
}