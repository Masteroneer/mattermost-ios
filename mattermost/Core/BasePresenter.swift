//
//  BasePresenter.swift
//  mattermost
//
//  Created by Vadim Salmin on 15/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

// Protocol to assemble presenter. need for assemble mvp, viper...
protocol BasePresenterAssemblerProtocol {
  init()
  func assemble(baseView: BaseViewPresenterProtocol, baseRouter: BasePresenterRouterProtocol, baseInputParams: BaseInputParamsProtocol?) -> BasePresenterProtocol
}

// Protocol to interact presenter with view
protocol BaseViewPresenterProtocol: class {}

// Input params for module
protocol BaseInputParamsProtocol {}


protocol BasePresenterProtocol: class {
  init(baseView: BaseViewPresenterProtocol, inputParams: BaseInputParamsProtocol?)
  func update(with inputParams: BaseInputParamsProtocol)
}


class BasePresenter: BasePresenterProtocol {
  internal weak var baseView: BaseViewPresenterProtocol?
  
  required init(baseView: BaseViewPresenterProtocol, inputParams: BaseInputParamsProtocol?) {
    self.baseView = baseView
  }
  
  func update(with inputParams: BaseInputParamsProtocol) {}
}
