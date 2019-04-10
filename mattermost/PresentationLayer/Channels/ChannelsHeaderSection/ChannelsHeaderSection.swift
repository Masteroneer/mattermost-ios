//
//  ChannelsHeaderSection.swift
//  mattermost
//
//  Created by Вадим on 10/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

final class ChannelsHeaderSection: UIView, NibLoadable {
  @IBOutlet weak var textLabel: UILabel!
  
  func update(text: String) {
    textLabel.text = text.uppercased()
  }
}
