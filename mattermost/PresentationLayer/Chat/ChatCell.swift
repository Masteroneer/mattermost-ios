//
//  ChatCell.swift
//  mattermost
//
//  Created by vadim on 11/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

class ChatCell: UITableViewCell, NibLoadable {
  @IBOutlet weak var avatarView: UIView!
  
  @IBOutlet weak var name: UILabel!
  
  @IBOutlet weak var messageText: UILabel!
  @IBOutlet weak var messageBackgroundView: UIView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    avatarView.layer.cornerRadius = avatarView.frame.width / 2
    avatarView.layer.masksToBounds = false
    
    messageBackgroundView.layer.cornerRadius = 10
    messageBackgroundView.layer.masksToBounds = false
  }
}
