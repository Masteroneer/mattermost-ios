//
//  InputServerAssembler.swift
//  mattermost
//
//  Created by Vadim Salmin on 15/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

class InputServerAssembler: BaseAssemblerProtocol {
  var presenterFactory: BasePresenterFactoryProtocol.Type { return InputServerPresenterFactory.self }
  var router: BaseRouterProtocol.Type { return InputServerRouter.self }
}
