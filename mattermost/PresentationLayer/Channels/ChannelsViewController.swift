//
//  File.swift
//  mattermost
//
//  Created by user on 02/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

struct ChannelViewData: Equatable {
  var name: String
  var lastMessage: String
}

protocol ChannelsViewProtocol: BaseViewProtocol {
  func updateDisplayChannels(_ channels: [ChannelViewData])
}

final class ChannelsViewController: BaseViewController, ChannelsViewProtocol, UITableViewDataSource {
  
  let channelCellIndentifier = "ChannelCellIdentifier"
  
  @IBOutlet weak var tableView: UITableView!
  
  private var presenter: ChannelsPresenterProtocol? { return basePresenter as? ChannelsPresenterProtocol }
  private var channels: [ChannelViewData] = [
    ChannelViewData(name: "Some Channel Name", lastMessage: "Vsem privet"),
    ChannelViewData(name: "Some Channel Name", lastMessage: "Vsem privet"),
    ChannelViewData(name: "Some Channel Name", lastMessage: "Vsem privet"),
    ChannelViewData(name: "Some Channel Name", lastMessage: "Vsem privet"),
    ChannelViewData(name: "Some Channel Name", lastMessage: "Vsem privet")
  ]
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initTableView()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    presenter?.onWillAppear()
  }
  
  // MARK: - ChannelsViewProtocol
  
  func updateDisplayChannels(_ channels: [ChannelViewData]) {
    self.channels = channels
    tableView.reloadData()
//    let changeset = StagedChangeset.init
//    tableView.reload(using: changeset) { channels in
//      self.channels = channels
//    }
  }
  
  // MARK: - UITableView methods
  
  func initTableView() {
    tableView.dataSource = self
    
    tableView.register(cellType: ChannelCell.self)
  }
  
  // MARK: - UITableViewDataSource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return channels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ChannelCell.self)
    let channel = channels[indexPath.row]
    let channelCellData = ChannelCellData(name: channel.name, lastMessage: channel.lastMessage)
    cell.update(with: channelCellData)
    return cell
  }
}
