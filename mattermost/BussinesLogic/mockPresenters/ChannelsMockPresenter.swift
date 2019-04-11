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
      Channel(id: "ewqadqwdca3123", name: "Off-Topic", type: .public, lastMessage: "Monday is best day ever."),
      Channel(id: "18dju1j02d1j0d129", name: "Town Square", type: .public, lastMessage: "Working..."),
      Channel(id: "dsd10rd9129j192", name: "Mattermost", type: .public, lastMessage: "I'm gonna make my own group chat with blackjack and bugs"),
      Channel(id: "jw1i1ie2i193i129", name: "VK Developers", type: .public, lastMessage: "Let's make some crypto coins!"),
      
      Channel(id: "dw19d902i9i9012", name: "True mobile devs", type: .private, lastMessage: "One of the important thing in mobile dev is..."),
      Channel(id: "hgjtrsadqw1o0i21021", name: "Rick and Morty", type: .private, lastMessage: "WUBBA LUBBA DUB DUB"),
      
      Channel(id: "fogkpdgdpf557jj65", name: "Morty", type: .directMessage, lastMessage: "Where Rick??")
    ]
    
    for channel in channels {
      DispatchQueue.main.asyncAfter(wallDeadline: .now() + 0.5) { [weak self] in
        guard let strongSelf = self else { return }
        strongSelf.view?.display(channel: channel)
      }
    }
  }
  
  func onSelect(channel: Channel) {
    print(channel)
  }
}
