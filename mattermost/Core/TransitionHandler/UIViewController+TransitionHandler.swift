//
//  UIViewController+TransitionHandler.swift
//  mattermost
//
//  Created by Vadim Salmin on 18/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController: TransitionHandlerProtocol {
  func push(viewController: UIViewController, animated: Bool) {
    guard let navigationController = navigationController else { return }
    
    navigationController.pushViewController(viewController, animated: animated)
  }
  
  func pop(animated: Bool) -> UIViewController? {
    return navigationController?.popViewController(animated: animated)
  }
}
