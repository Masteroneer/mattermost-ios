//
//  Post.swift
//  mattermost
//
//  Created by user on 05/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

struct PostModel: Codable {
  var id: String
  var userId: String
  var channelId: String
  var rootId: String
  var parentId: String
  var originalId: String
  var message: String
  var type: String
//  var hashtag: String
//  var fileIds: [String]
//  var pendingPostId: String
  
  enum CodingKeys: String, CodingKey {
    case id
    case userId = "user_id"
    case channelId = "channel_id"
    case rootId = "root_id"
    case parentId = "parent_id"
    case originalId = "original_id"
    case message
    case type
//    case hashtag
//    case fileIds = "file_ids"
//    case pendingPostId = "pending_post_id"
  }
}

struct ChannelPostModel: Codable {
  var order: [String]
  var posts: [String: PostModel]
  
  enum CodingKeys: String, CodingKey {
    case order
    case posts
  }
}
