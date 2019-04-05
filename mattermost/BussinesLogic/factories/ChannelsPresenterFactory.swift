//
//  ChannelsPresenterFactory.swift
//  mattermost
//
//  Created by user on 02/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class ChannelsPresenterFactory: BasePresenterFactoryProtocol {
  func createMVPPresenter(baseView: BaseViewPresenterProtocol,
                          baseRouter: BasePresenterRouterProtocol,
                          baseInputParams: BaseInputParamsProtocol?) -> BasePresenterProtocol {
    let presenter = ChannelsMVPPresenter(baseView: baseView, baseRouter: baseRouter, inputParams: baseInputParams)
    presenter.teamsService = Utils.shared.createService(serviceType: TeamsService.self)
    presenter.channelsService = Utils.shared.createService(serviceType: ChannelsService.self)
    presenter.postsService = Utils.shared.createService(serviceType: PostsService.self)
    return presenter
  }
}
