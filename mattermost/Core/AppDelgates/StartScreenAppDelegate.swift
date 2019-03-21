//
//  StartScreenAppDelegate.swift
//  mattermost
//
//  Created by user on 20/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import UIKit
import Foundation

class StartScreenAppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = UINavigationController(rootViewController: getRootViewController())
    window?.makeKeyAndVisible()
    return true
  }
  
  // TODO: - Убрать опционалы
  func getRootViewController() -> UIViewController {
    let serverUrlsService: ServerUrlsServiceProtocol = ServerUrlsService()
    
    var viewController: BaseViewController?
    let assembler: BaseAssemblerProtocol?
    
    if let _ = serverUrlsService.getLastAccessedUrl() {
      viewController = LoginViewController()
      assembler = LoginAssembler()
    } else {
      viewController = InputServerViewController()
      assembler = InputServerAssembler()
    }
    
    assembler!.assemble(with: viewController!, and: nil)
    
    return viewController!
  }
}
