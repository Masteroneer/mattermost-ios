//
//  LoginAssembler.swift
//  mattermost
//
//  Created by Вадим Салмин on 18.03.2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class LoginAssembler: BaseAssemblerProtocol {
  var presenterFactory: BasePresenterFactoryProtocol.Type { return LoginPresenterFactory.self }
  var theme: BaseThemeProtocol.Type { return LoginTheme.self }
  var router: BaseRouterProtocol.Type { return LoginRouter.self }
}
