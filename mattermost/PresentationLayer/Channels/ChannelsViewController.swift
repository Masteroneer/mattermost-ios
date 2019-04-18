//
//  File.swift
//  mattermost
//
//  Created by user on 02/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

enum ChannelType: Int {
  case `public`, `private`, directMessage
}

struct Channel: Equatable {
  var id: String
  var name: String
  var type: ChannelType
  var lastMessage: String
}

protocol ChannelsViewProtocol: BaseViewProtocol {
  
  /// Need to display multiple channels (batch display)
  /// Example:
  ///
  /// let channels = ...channels to display
  /// view.beginUpdate()
  /// for channel in channels {
  ///   view.display(channel: channel)
  /// }
  /// view.endUpdate()
  func beginUpdate()
  func endUpdate()
  
  
  func display(channel: Channel)
}

final class ChannelsViewController: BaseViewController, ChannelsViewProtocol, UITableViewDataSource, UITableViewDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  
  // MARK: - private
  
  private var presenter: ChannelsPresenterProtocol? { return basePresenter as? ChannelsPresenterProtocol }
  private var channels: [Channel] = []
  private var isBatchUpdating = false
  
  // Find difference between two arrays of type Section and return difference
//  private func diffBetweenArrays(original: [Section], new: [Section]) -> [Section] {
//
//  }
  
  private func getChannels(with type: ChannelType) -> [Channel] {
    return channels.filter { (channel) -> Bool in
      return channel.type == type
    }
  }
  
  private func getChannel(for indexPath: IndexPath) -> Channel {
    guard let channelType = ChannelType(rawValue: indexPath.section) else { fatalError() }
    return getChannels(with: channelType)[indexPath.row]
  }
  
  private func getTitle(for section: Int) -> String? {
    guard let channelType = ChannelType(rawValue: section) else { return nil }
    
    switch channelType {
    case .public:
      return "public channels"
    case .private:
      return "private channels"
    case .directMessage:
      return "direct messages"
    }
  }
  
  // MARK: - Life cycle
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    channels.removeAll()
    tableView.reloadData()
    
    presenter?.onWillAppear()
  }
  
  
  // MARK: - ChannelsViewProtocol
  
  
  func beginUpdate() {
    isBatchUpdating = true
  }
  
  func endUpdate() {
    isBatchUpdating = false
  }
  
  func display(channel: Channel) {
    channels.append(channel)
    
    if !isBatchUpdating {
      let indexPath = IndexPath(row: getChannels(with: channel.type).count - 1, section: channel.type.rawValue)
      tableView.insertRows(at: [indexPath], with: .fade)
    }
  }
  
  
  // MARK: - UITableView methods
  
  
  func initTableView() {
    tableView.dataSource = self
    tableView.delegate = self
    
    tableView.register(cellType: ChannelsCell.self)
  }
  
  
  // MARK: - UITableViewDataSource
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 3
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let channelType = ChannelType(rawValue: section) else { fatalError() }
    return getChannels(with: channelType).count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ChannelsCell.self)
    let channel = getChannel(for: indexPath)
    let channelCellData = ChannelCellData(name: channel.name, lastMessage: channel.lastMessage)
    cell.update(with: channelCellData)
    return cell
  }
  
  
  // MARK: - UITableViewDelegate
  
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30 // TODO: - пофиксить
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    guard let title = getTitle(for: section) else { return nil }
    
    let view = ChannelsHeaderSection.loadFromNib()
    view.update(text: title)
    return view
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    presenter?.onSelect(channel: getChannel(for: indexPath))
  }
}
