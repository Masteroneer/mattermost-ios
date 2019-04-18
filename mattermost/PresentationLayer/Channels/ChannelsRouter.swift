//
//  ChannelsRouter.swift
//  mattermost
//
//  Created by vadim on 15/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

protocol ChannelsRouterProtocol: BaseRouterProtocol {
  func showChat(for channel: Channel)
}

final class ChannelsRouter: BaseRouter, ChannelsRouterProtocol {
  func showChat(for channel: Channel) {
    let chatViewController = ChatViewController()
    let assembler = ChatAssembler()
    assembler.assemble(with: chatViewController, and: nil)
    
    transitionHandler.push(viewController: chatViewController, animated: true)
  }
}
