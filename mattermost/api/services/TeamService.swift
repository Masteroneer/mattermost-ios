//
//  Teamservice.swift
//  mattermost
//
//  Created by user on 26/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

protocol TeamsServiceProtocol: BaseServiceProtocol {
  func getTeams()
}

final class TeamsService: BaseService, TeamsServiceProtocol {
  override var servicePathComponent: String { return "teams" }
  
  func getTeams() {
    authorizedRequest(methodPathComponent: nil, method: .get, parameters: nil).responseString { (res) in
      print(res)
    }
  }
}
