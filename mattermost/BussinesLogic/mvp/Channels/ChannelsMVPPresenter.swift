//
//  ChannelsMVPPresenter.swift
//  mattermost
//
//  Created by user on 02/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class ChannelsMVPPresenter: BasePresenter, ChannelsPresenterProtocol {
  var teamsService: TeamsServiceProtocol?

  func onWillAppear() {
    teamsService?.getMyTeams(completion: { (result) in
      switch result {
      case .success(let teams):
        print(teams)
      case .failure(let error):
        print(error)
      }
    })
  }
}
