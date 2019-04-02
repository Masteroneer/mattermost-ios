//
//  ChannelsAssembler.swift
//  mattermost
//
//  Created by user on 02/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class ChannelsAssembler: BaseAssemblerProtocol {
  var presenterFactory: BasePresenterFactoryProtocol.Type { return ChannelsPresenterFactory.self }
  var router: BaseRouterProtocol.Type { return BaseRouter.self }
}
