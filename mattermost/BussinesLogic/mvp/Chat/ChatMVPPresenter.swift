//
//  ChatMVPPresenter.swift
//  mattermost
//
//  Created by vadim on 12/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class ChatMVPPresenter: BasePresenter, ChatPresenterProtocol {
  var postsService: PostsServiceProtocol?
  
  func onViewWillAppear() {}
}
