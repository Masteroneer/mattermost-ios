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
    printd("===============================")
    var str = ""
    for item in items {
      str += "\(item)"
    }
    printd("\(group) \(str)")
  }
  
  func printd(_ object: Any) {
    #if DEBUG
    print(object)
    #endif
  }
}
