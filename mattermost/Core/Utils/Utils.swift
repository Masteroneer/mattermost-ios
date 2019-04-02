//
//  Utils.swift
//  mattermost
//
//  Created by user on 02/04/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

class Utils {
  static let shared = Utils()
  
  func createService<Service: BaseServiceProtocol>(serviceType: Service.Type) -> Service {
    let lastUrlString = ServerUrlsService().getLastAccessedUrl()
    let lastUrl = URL(string: lastUrlString!)
    return serviceType.init(baseUrl: lastUrl!, version: .v4)
  }
}
