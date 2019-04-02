//
//  BaseThemeFactory.swift
//  mattermost
//
//  Created by user on 02/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

protocol BaseThemeProtocol {
  var backgroundColor: UIColor { get }
  init()
}

protocol BaseThemeFactoryProtocol {
  init()
  func createDefaultTheme() -> BaseThemeProtocol
}
