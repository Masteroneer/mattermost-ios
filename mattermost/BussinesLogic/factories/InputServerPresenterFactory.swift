//
//  InputServerFactory.swift
//  mattermost
//
//  Created by Vadim Salmin on 19/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class InputServerPresenterFactory: BasePresenterFactoryProtocol {
  func createMVPPresenter(baseView: BaseViewPresenterProtocol,
                          baseRouter: BasePresenterRouterProtocol,
                          baseInputParams: BaseInputParamsProtocol?) -> BasePresenterProtocol {
    let presenter = InputServerMVPPresenter(baseView: baseView, baseRouter: baseRouter, inputParams: baseInputParams)
    presenter.serverUrlsService = ServerUrlsService()
    return presenter
  }
  
  func createMockPresenter(baseView: BaseViewProtocol,
                           baseRouter: BasePresenterRouterProtocol,
                           baseInputParams: BaseInputParamsProtocol?) -> BasePresenterProtocol {
    return createMVPPresenter(baseView: baseView, baseRouter: baseRouter, baseInputParams: baseInputParams)
  }
}
