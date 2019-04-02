//
//  Channel.swift
//  mattermost
//
//  Created by user on 02/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

struct ChannelModel: Codable {
  var id: String
  var teamId: String
  var type: String
  var displayName: String
  var name: String
  var header: String
  var purpose: String
  var lastPostAt: Int
  var totalMsgCount: Int
  var createrId: Int
  
  enum CodingKeys: String, CodingKey {
    case id
    case teamId = "team_id"
    case type
    case displayName = "display_name"
    case name
    case header
    case purpose
    case lastPostAt = "last_post_at"
    case totalMsgCount = "total_msg_count"
    case createrId = "creater_id"
  }
}
