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
  
  func getRootViewController() -> UIViewController {
    let serverUrlsService: ServerUrlsServiceProtocol = ServerUrlsService()
    
    var viewController: BaseViewController?
    let assembler: BaseAssemblerProtocol?
    
    // Check if user authorized
    if let lastUrlStr = serverUrlsService.getLastAccessedUrl() {
      let lastUrl = URL(string: lastUrlStr)
      let baseService = BaseService(baseUrl: lastUrl!, version: .v4)
      if baseService.isAuthorized() {
        let channelsVC = ChannelsViewController()
        let channelsAssembler = ChannelsAssembler()
        channelsAssembler.assemble(with: channelsVC, and: nil)
        return channelsVC
      }
    }
    
    // User doesnt authorized
    if let _ = serverUrlsService.getLastAccessedUrl() {
      viewController = LoginViewController()
      assembler = LoginAssembler()
    } else {
      viewController = InputServerViewController()
      assembler = InputServerAssembler()
    }
    
    assembler?.assemble(with: viewController!, and: nil)
    
    return viewController!
  }
}
