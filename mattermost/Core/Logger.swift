//
//  Logger.swift
//  mattermost
//
//  Created by user on 26/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

class Logger {
  static var shared = Logger()
  
  func printd(group: String, _ items: Any...) {
    printd(group, items)
  }
  
  func printd(_ items: Any...) {
    #if DEBUG
    print(items)
    #endif
  }
}
