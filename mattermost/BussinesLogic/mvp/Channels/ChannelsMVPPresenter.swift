//
//  ChannelsMVPPresenter.swift
//  mattermost
//
//  Created by user on 02/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

final class ChannelsMVPPresenter: BasePresenter, ChannelsPresenterProtocol {
  var teamsService: TeamsServiceProtocol?
  var channelsService: ChannelsServiceProtocol?
  var postsService: PostsServiceProtocol?

  private var channels: [ChannelModel] = []
  private var posts: [ChannelPostModel] = []
  private var view: ChannelsViewProtocol? { return baseView as? ChannelsViewProtocol }
  private var router: ChannelsRouterProtocol? { return baseRouter as? ChannelsRouterProtocol }
  
  func onWillAppear() {
    getMyTeams()
  }
  
  func onSelect(channel: Channel) {
    router?.showChat(for: channel)
  }
  
  // MARK: - private methods
  
  private func getMyTeams() {
    teamsService?.getMyTeams(completion: { [weak self] (result) in
      guard let strongSelf = self else { return }
      
      switch result {
      case .success(let teams):
        strongSelf.getMyChannels(for: teams.first!)
      case .failure(let error):
        print(error)
      }
    })
  }
  
  private func getMyChannels(for team: TeamModel) {
    channelsService?.getMyChannels(teamId: team.id, completion: { [weak self] (result) in
      guard let strongSelf = self else { return }
      
      switch result {
      case .success(let channels):
        strongSelf.onSuccess(channels: channels)
      case .failure(let error):
        print(error)
      }
    })
  }
  
  private func onSuccess(channels: [ChannelModel]) {
    self.channels = channels
    
    for channel in channels {
      getFirstPost(for: channel)
    }
  }
  
  private func getFirstPost(for channel: ChannelModel) {
    postsService?.getPosts(for: channel.id,
                           with: [.perPage(1)],
                           completion: { [weak self] (result) in
      guard let strongSelf = self else { return }

      switch result {
      case .success(let posts):
        strongSelf.posts.append(posts)
        if let post = posts.posts.first?.value {
          strongSelf.display(channel: channel, with: post)
        }
      case .failure(let error):
        print(error)
      }
    })
  }
  
  private func display(channel: ChannelModel, with post: PostModel) {
    let channelType: ChannelType = getChannelType(from: channel.type)
    let viewChannel = Channel(id: channel.id, name: channel.displayName, type: channelType, lastMessage: post.message)
    view?.display(channel: viewChannel)
  }
  
  private func getChannelType(from string: String) -> ChannelType {
    switch string {
    case "O":
      return .public
    case "P":
      return .private
    default:
      return .directMessage
    }
  }
}
