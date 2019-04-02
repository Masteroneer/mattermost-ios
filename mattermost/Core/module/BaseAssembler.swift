//
//  BaseAssembler.swift
//  mattermost
//
//  Created by Vadim Salmin on 15/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

protocol BaseAssemblerProtocol {
  var presenterFactory: BasePresenterFactoryProtocol.Type { get }
  //var themeFactory: BaseThemeFactoryProtocol.Type { get }
  var router: BaseRouterProtocol.Type { get }
}

extension BaseAssemblerProtocol {
  func assemble(with view: BaseViewProtocol, and inputParams: BaseInputParamsProtocol?) {
    // theme
//    let themeFactoryInstance = themeFactory.init()
//    view.baseThemeFactory = themeFactoryInstance.createDefaultTheme()

    // router
    let routerInstance = router.init(view)
    
    // presenter
    let presenterFactoryInstance = presenterFactory.init()
    let presenterInstance = presenterFactoryInstance.createMVPPresenter(baseView: view, baseRouter: routerInstance, baseInputParams: inputParams)
    
    // view
    view.basePresenter = presenterInstance
  }
}
