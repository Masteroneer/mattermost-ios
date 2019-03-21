//
//  InputServerRouter.swift
//  mattermost
//
//  Created by Вадим Салмин on 18.03.2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

protocol InputServerPresenterRouterProtocol: BasePresenterRouterProtocol {
  func goToLogin()
}

class InputServerRouter: BaseRouter, InputServerPresenterRouterProtocol {
  func goToLogin() {
    let vc = LoginViewController()
    let assembler = LoginAssembler()
    assembler.assemble(with: vc, and: nil)
    transitionHandler.push(viewController: vc, animated: true)
  }
}
