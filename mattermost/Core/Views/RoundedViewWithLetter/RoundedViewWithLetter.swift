//
//  RoundedViewWithLatter.swift
//  mattermost
//
//  Created by user on 05/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class RoundedViewWithLetter: UIView, NibOwnerLoadable {
  @IBOutlet weak var label: UILabel!
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.loadNibContent()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    layer.cornerRadius = 25
    layer.masksToBounds = true
  }
}
