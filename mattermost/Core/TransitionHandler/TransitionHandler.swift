//
//  TransitionHandler.swift
//  mattermost
//
//  Created by Vadim Salmin on 18/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

protocol TransitionHandlerProtocol {
  func push(viewController: UIViewController, animated: Bool)
  func pop(animated: Bool) -> UIViewController?
}
