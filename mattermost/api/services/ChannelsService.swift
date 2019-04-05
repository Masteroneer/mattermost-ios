//
//  ChannelsService.swift
//  mattermost
//
//  Created by user on 02/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

protocol ChannelsServiceProtocol: BaseServiceProtocol {
  func getPublicChannels(teamId: String, completion: @escaping (ApiResult<[ChannelModel], ErrorModel>) -> Void)
  func getMyPublicChannels(teamId: String, completion: @escaping (ApiResult<[ChannelModel], ErrorModel>) -> Void)
}

final class ChannelsService: BaseService, ChannelsServiceProtocol {
  override var servicePathComponent: String { return "channels" }
  
  func getPublicChannels(teamId: String, completion: @escaping (ApiResult<[ChannelModel], ErrorModel>) -> Void) {
    serializableAuthorizedRequest(methodPathComponent: "teams/\(teamId)/channels",
                                  method: .get,
                                  parameters: nil,
                                  completion: completion)
  }
  
  func getMyPublicChannels(teamId: String, completion: @escaping (ApiResult<[ChannelModel], ErrorModel>) -> Void) {
    serializableAuthorizedRequest(methodPathComponent: "users/me/teams/\(teamId)/channels",
                                  method: .get,
                                  parameters: nil,
                                  completion: completion)
  }
}
