//
//  InputServerTheme.swift
//  mattermost
//
//  Created by Vadim Salmin on 15/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

protocol InputServerThemeProtocol: BaseThemeProtocol {}

final class InputServerTheme: InputServerThemeProtocol {
  var backgroundColor: UIColor { return UIColor.white }
}
