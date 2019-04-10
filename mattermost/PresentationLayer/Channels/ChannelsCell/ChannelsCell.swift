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

final class ChannelsCell: UITableViewCell, NibLoadable {
  @IBOutlet weak var roundedViewWithLetter: RoundedViewWithLetter!
  @IBOutlet weak var name: UILabel!
  @IBOutlet weak var lastPostMessage: UILabel!
  
  func update(with data: ChannelCellData) {
    roundedViewWithLetter.label.text = String(data.name.first ?? "A").uppercased()
    name.text = data.name
    lastPostMessage.text = data.lastMessage
  }
}
