//
//  ChannelCell.swift
//  mattermost
//
//  Created by user on 04/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

struct ChannelCellData {
  var name: String
  var lastMessage: String
}

final class ChannelCell: UITableViewCell, NibLoadable {
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var lastPostMessage: UILabel!
  
  func update(with data: ChannelCellData) {
    name.text = data.name
    lastPostMessage.text = data.lastMessage
  }
}
