//
//  ChannelsMockPresenter.swift
//  mattermost
//
//  Created by Вадим on 10/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class ChannelsMockPresenter: BasePresenter, ChannelsPresenterProtocol {
  
  private var view: ChannelsViewProtocol? { return baseView as? ChannelsViewProtocol }
  
  func onWillAppear() {
    let channels = [
      Channel(name: "Off-Topic", type: .public, lastMessage: "Monday is best day ever."),
      Channel(name: "Town Square", type: .public, lastMessage: "Working..."),
      Channel(name: "Mattermost", type: .public, lastMessage: "I'm gonna make my own group chat with blackjack and bugs"),
      Channel(name: "VK Developers", type: .public, lastMessage: "Let's make some crypto coins!"),
      
      Channel(name: "True mobile devs", type: .private, lastMessage: "One of the important thing in mobile dev is..."),
      Channel(name: "Rick and Morty", type: .private, lastMessage: "WUBBA LUBBA DUB DUB"),
      
      Channel(name: "Morty", type: .directMessage, lastMessage: "Where Rick??")
    ]
    
    for channel in channels {
      DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.view?.display(channel: channel)
      }
    }
  }
}
