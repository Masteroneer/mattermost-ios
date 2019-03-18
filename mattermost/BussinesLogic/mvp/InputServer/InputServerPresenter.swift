//
//  InputServerPresenter.swift
//  mattermost
//
//  Created by Vadim Salmin on 15/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class InputServerPresenter: BasePresenter, InputServerPresenterProtocol {
  
  var serverUrlsService: ServerUrlsService?
  
  var serverUrl: String = ""
  
  // MARK: - Input Server Presenter Protocol
  
  func onDidEndEditingUrl(text: String) {
    serverUrl = text
  }
  
  func onNextPressed() {
    serverUrlsService?.addServerUrl(serverUrl)
  }
}
