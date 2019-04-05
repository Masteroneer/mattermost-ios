//
//  PostsService.swift
//  mattermost
//
//  Created by user on 05/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

protocol PostsServiceProtocol: BaseServiceProtocol {
  func getPosts(for channelId: String, completion: @escaping (ApiResult<ChannelPostModel, ErrorModel>) -> Void)
}

final class PostsService: BaseService, PostsServiceProtocol {  
  override var servicePathComponent: String { return "posts" }
  
  func getPosts(for channelId: String, completion: @escaping (ApiResult<ChannelPostModel, ErrorModel>) -> Void) {
    serializableAuthorizedRequest(methodPathComponent: "channels/\(channelId)/posts",
                                  method: .get,
                                  parameters: ["per_page": "1"],
                                  completion: completion)
  }
}
