//
//  BaseAssembler.swift
//  mattermost
//
//  Created by Vadim Salmin on 15/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

typealias assemblerView = BaseViewProtocol & BaseViewPresenterProtocol & TransitionHandlerProtocol // TODO: Заменить. че то это супержестко получилось

protocol BaseAssemblerProtocol {
  var presenterAssembler: BasePresenterAssemblerProtocol.Type { get }
  var theme: BaseThemeProtocol.Type { get }
  var router: BasePresenterRouterProtocol.Type { get }
}

extension BaseAssemblerProtocol {
  func assemble(with view: assemblerView, and inputParams: BaseInputParamsProtocol?) {
    // theme
    let themeInstance = theme.init()
    view.baseTheme = themeInstance
  
    // router
    let routerInstance = (router as? BaseRouterProtocol.Type)!.init(view)
    
    // presenter
    let presenterAssemblerInstance = presenterAssembler.init()
    let presenterInstance = presenterAssemblerInstance.assemble(baseView: view, baseRouter: routerInstance, baseInputParams: inputParams)
    
    // view
    view.basePresenter = presenterInstance
  }
}
