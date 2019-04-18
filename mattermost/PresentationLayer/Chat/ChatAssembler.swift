//
//  ChatAssembler.swift
//  mattermost
//
//  Created by vadim on 11/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class ChatAssembler: BaseAssemblerProtocol {
  var presenterFactory: BasePresenterFactoryProtocol.Type { return ChannelsPresenterFactory.self }
  var router: BaseRouterProtocol.Type { return BaseRouter.self }
}
