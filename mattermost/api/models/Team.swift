//
//  Team.swift
//  mattermost
//
//  Created by user on 29/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

struct TeamModel: Codable {
  var id: String
  var displayName: String
  var name: String
  var description: String
  var email: String
  var type: String
  var allowedDomains: String
  var inviteId: String
  var allowOpenInvite: Bool
  
  enum CodingKeys: String, CodingKey {
    case id
    case displayName = "display_name"
    case name
    case description
    case email
    case type
    case allowedDomains = "allowed_domains"
    case inviteId = "invite_id"
    case allowOpenInvite = "allow_open_invite"
  }
}
