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
  init(_ view: TransitionHandlerProtocol)
}

class BaseRouter: BaseRouterProtocol {
  internal var handlerTransition: TransitionHandlerProtocol
  
  required init(_ handlerTransition: TransitionHandlerProtocol) {
    self.handlerTransition = handlerTransition
  }
}
