//
//  Teamservice.swift
//  mattermost
//
//  Created by user on 26/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

protocol TeamsServiceProtocol: BaseServiceProtocol {
  func getTeams(completion: @escaping (ApiResult<[TeamModel], ErrorModel>) -> Void)
  func getMyTeams(completion: @escaping (ApiResult<[TeamModel], ErrorModel>) -> Void)
}

final class TeamsService: BaseService, TeamsServiceProtocol {
  override var servicePathComponent: String { return "teams" }
  
  func getTeams(completion: @escaping (ApiResult<[TeamModel], ErrorModel>) -> Void) {
    isMyRequest = false
    serializableAuthorizedRequest(methodPathComponent: nil,
                                  method: .get,
                                  parameters: nil,
                                  completion: completion)
  }
  
  func getMyTeams(completion: @escaping (ApiResult<[TeamModel], ErrorModel>) -> Void) {
    isMyRequest = true
    // TODO: - ДА ДА КОСТЫЛЬ НА КОСТЫЛЕ
    serializableAuthorizedRequest(methodPathComponent: nil,
                                  method: .get,
                                  parameters: nil,
                                  completion: completion)
  }
}
