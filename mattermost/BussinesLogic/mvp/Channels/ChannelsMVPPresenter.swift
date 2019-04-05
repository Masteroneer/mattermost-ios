//
//  ChannelsMVPPresenter.swift
//  mattermost
//
//  Created by user on 02/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class ChannelsMVPPresenter: BasePresenter, ChannelsPresenterProtocol {
  private var view: ChannelsViewProtocol? { return baseView as? ChannelsViewProtocol }
  
  var teamsService: TeamsServiceProtocol?
  var channelsService: ChannelsServiceProtocol?
  var postsService: PostsServiceProtocol?

  private var channels: [ChannelModel] = []
  private var posts: [ChannelPostModel] = []
  
  func onWillAppear() {
    teamsService?.getMyTeams(completion: { [weak self] (result) in
      guard let strongSelf = self else { return }
      
      switch result {
        case .success(let teams):
          strongSelf.onSuccess(teams: teams)
        case .failure(let error):
          print(error)
      }
    })
  }
  
  // MARK: - private methods
  
  private func onSuccess(teams: [TeamModel]) {
    channelsService?.getMyPublicChannels(teamId: teams[0].id, completion: { [weak self] (result) in
      guard let strongSelf = self else { return }
      
      switch result {
        case .success(let channels):
          strongSelf.onSuccess(channels: channels)
        case .failure(let error):
          print(error)
      }
    })
  }
  
  // Perfroms if GetPublicChannels return success result
  private func onSuccess(channels: [ChannelModel]) {
    self.channels = channels
    
    for channel in channels {
      getPosts(for: channel.id)
    }
  }
  
  private func getPosts(for channelId: String) {
    postsService?.getPosts(for: channelId, completion: { [weak self] (result) in
      guard let strongSelf = self else { return }
      
      switch result {
      case .success(let posts):
        strongSelf.posts.append(posts)
        strongSelf.updateDisplayChannels()
      case .failure(let error):
        print(error)
      }
    })
  }
  
  private func updateDisplayChannels() {
    var displayChannels = [ChannelViewData]()
    
    posts.forEach { (post) in
      let channel = channels.first(where: { (channel) -> Bool in
        return channel.id == post.posts.first?.value.channelId
      })
      
      if let channelDisplayName = channel?.displayName,
        !channelDisplayName.isEmpty {
        let displayChannel = ChannelViewData(name: channelDisplayName, lastMessage: post.posts.first!.value.message)
        displayChannels.append(displayChannel)
      }
    }
    
    view?.updateDisplayChannels(displayChannels)
  }
}
