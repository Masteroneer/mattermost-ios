//
//  User.swift
//  mattermost
//
//  Created by Vadim Salmin on 15/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

struct UserModel: Codable {
  var id: String
  var username: String
  
  enum CodingKeys: String, CodingKey {
    case id, username
  }
}
