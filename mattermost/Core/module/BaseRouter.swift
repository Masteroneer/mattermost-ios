//
//  Router.swift
//  mattermost
//
//  Created by Vadim Salmin on 18/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

// Protocol to interact presenter with router
protocol BasePresenterRouterProtocol {}

protocol BaseRouterProtocol: BasePresenterRouterProtocol {
  // view with TransitionHandlerProtocol
  init(_ view: TransitionHandlerProtocol)
}

class BaseRouter: BaseRouterProtocol {
  // TODO: - weak
  var transitionHandler: TransitionHandlerProtocol
  
  required init(_ transitionHandler: TransitionHandlerProtocol) {
    self.transitionHandler = transitionHandler
  }
}
