//
//  PostsService.swift
//  mattermost
//
//  Created by user on 05/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

enum Parameter {
  case page(Int)
  case perPage(Int)

  func toString() -> (key: String, value: String) {
    switch self {
    case .page(let page):
      return ("page", String(page))
    case .perPage(let results):
      return ("per_page", String(results))
    }
  }
}

protocol PostsServiceProtocol: BaseServiceProtocol {
  func getPosts(for channelId: String,
                with parameters: [Parameter],
                completion: @escaping (ApiResult<ChannelPostModel, ErrorModel>) -> Void)
}

final class PostsService: BaseService, PostsServiceProtocol {  
  override var servicePathComponent: String { return "posts" }
  
  func getPosts(for channelId: String,
                with parameters: [Parameter],
                completion: @escaping (ApiResult<ChannelPostModel, ErrorModel>) -> Void) {
    var strParameters: [String: String] = [:]
    for parameter in parameters {
      strParameters[parameter.toString().key] = parameter.toString().value
    }
    
    serializableAuthorizedRequest(methodPathComponent: "channels/\(channelId)/posts",
                                  method: .get,
                                  parameters: strParameters,
                                  completion: completion)
  }
}
