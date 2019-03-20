//
//  InputServerPresenter.swift
//  mattermost
//
//  Created by Vadim Salmin on 15/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class InputServerMVPPresenter: BasePresenter, InputServerPresenterProtocol {
  
  private var router: InputServerRouter? { return baseRouter as? InputServerRouter }
  
  var serverUrlsService: ServerUrlsService?
  
  var serverUrl: String = ""
  
  required init(baseView: BaseViewPresenterProtocol, baseRouter: BasePresenterRouterProtocol, inputParams: BaseInputParamsProtocol?) {
    super.init(baseView: baseView, baseRouter: baseRouter, inputParams: inputParams)
    
    // TODO: - Переход к логину если url уже есть, убрать потом
    if let serverUrlsService = serverUrlsService,
      let _ = serverUrlsService.getLastAccessedUrl() {
      router?.goToLogin()
    }
  }
  
  // MARK: - Input Server Presenter Protocol
  
  func onDidEndEditingUrl(text: String) {
    serverUrl = text
  }
  
  func onNextPressed() {
    serverUrlsService?.addServerUrl(serverUrl)
    router?.goToLogin()
  }
}
