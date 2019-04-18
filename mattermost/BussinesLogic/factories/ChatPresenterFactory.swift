//
//  ChatPresenterFactory.swift
//  mattermost
//
//  Created by vadim on 12/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class ChatPresenterFactory: BasePresenterFactoryProtocol {
  func createMVPPresenter(baseView: BaseViewPresenterProtocol,
                          baseRouter: BasePresenterRouterProtocol,
                          baseInputParams: BaseInputParamsProtocol?) -> BasePresenterProtocol {
    
    let presenter = ChatMVPPresenter(baseView: baseView, baseRouter: baseRouter, inputParams: baseInputParams)
    presenter.postsService = Utils.shared.createService(serviceType: PostsService.self)
    return presenter
  }
  
  func createMockPresenter(baseView: BaseViewProtocol,
                           baseRouter: BasePresenterRouterProtocol,
                           baseInputParams: BaseInputParamsProtocol?) -> BasePresenterProtocol {
    return ChatMockPresenter(baseView: baseView, baseRouter: baseRouter, inputParams: baseInputParams)
  }
}
