//
//  AppDelegate.swift
//  mattermost
//
//  Created by Vadim Salmin on 14/02/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import UIKit
import RamblerAppDelegateProxy

@UIApplicationMain
class AppDelegate: RamblerAppDelegateProxy {
  override init!() {
    super.init()
    addAppDelegate(StartScreenAppDelegate())
    //addAppDelegate(LoggerAppDelegate())
  }
}

