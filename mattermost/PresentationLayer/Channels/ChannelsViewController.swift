//
//  File.swift
//  mattermost
//
//  Created by user on 02/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

final class ChannelsViewController: BaseViewController {
  
  private var presenter: ChannelsPresenterProtocol? { return basePresenter as? ChannelsPresenterProtocol }
  
  // MARK: - Life cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    presenter?.onWillAppear()
  }
}
