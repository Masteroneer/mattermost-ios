//
//  BasePresenter.swift
//  mattermost
//
//  Created by Vadim Salmin on 15/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

protocol BasePresenterFactoryProtocol {
  init()
  func createPresenter(baseView: BaseViewPresenterProtocol, baseRouter: BasePresenterRouterProtocol, baseInputParams: BaseInputParamsProtocol?) -> BasePresenterProtocol
}

// Input params for module
protocol BaseInputParamsProtocol {}

protocol BasePresenterViewProtocol {}

protocol BasePresenterProtocol: class, BasePresenterViewProtocol {
  init(baseView: BaseViewPresenterProtocol, baseRouter: BasePresenterRouterProtocol, inputParams: BaseInputParamsProtocol?)
  func update(with inputParams: BaseInputParamsProtocol)
}

// Base implementation of presenter
class BasePresenter: BasePresenterProtocol {
  weak var baseView: BaseViewPresenterProtocol?
  
  var baseRouter: BasePresenterRouterProtocol
  
  required init(baseView: BaseViewPresenterProtocol, baseRouter: BasePresenterRouterProtocol, inputParams: BaseInputParamsProtocol?) {
    self.baseView = baseView
    self.baseRouter = baseRouter
  }
  
  func update(with inputParams: BaseInputParamsProtocol) {}
}
