//
//  LoginPresenterFactory.swift
//  mattermost
//
//  Created by Вадим Салмин on 18.03.2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class LoginPresenterFactory: BasePresenterFactoryProtocol {
  func createMVPPresenter(baseView: BaseViewPresenterProtocol,
                          baseRouter: BasePresenterRouterProtocol,
                          baseInputParams: BaseInputParamsProtocol?) -> BasePresenterProtocol {
    
    return LoginMVPPresenter(baseView: baseView, baseRouter: baseRouter, inputParams: baseInputParams)
  }
}
