//
//  Error.swift
//  mattermost
//
//  Created by user on 25/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

struct ErrorModel: Codable {
  var id: String
  var message: String
  var requestId: String
  var statusCode: Int
  var isOAuth: Bool
  
  enum CodingKeys: String, CodingKey {
    case id
    case message
    case requestId = "request_id"
    case statusCode = "status_code"
    case isOAuth = "is_oauth"
  }
}
