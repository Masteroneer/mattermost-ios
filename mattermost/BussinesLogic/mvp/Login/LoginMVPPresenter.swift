//
//  LoginPresenter.swift
//  mattermost
//
//  Created by Вадим Салмин on 18.03.2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class LoginMVPPresenter: BasePresenter, LoginPresenterProtocol {
  private var view: LoginViewProtocol? { return baseView as? LoginViewProtocol }
  private var router: LoginRouterProtocol? { return baseRouter as? LoginRouterProtocol }
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
    usersService.login(loginId: email, password: password) { [weak self] (result) in
      guard let strongSelf = self else { return }
      
      switch result {
      case .success(_):
        strongSelf.router?.goToChannelsList()
      case .failure(let error):
        strongSelf.view?.setErrorMessage(error.message)
      }
    }
  }
}
