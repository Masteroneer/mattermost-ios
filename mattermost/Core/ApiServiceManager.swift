//
//  ApiServiceManager.swift
//  mattermost
//
//  Created by Vadim Salmin on 19/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

/// Manager to create api services.
/// Incapsulate logic to create service with selected url.
class ApiServiceManager {
  private let serverUrlsService: ServerUrlsServiceProtocol
  static let shared = ApiServiceManager()
  
  init() {
    serverUrlsService = ServerUrlsService()
  }
  
  func createService<Service:BaseService>(from serviceType: Service.Type) -> Service {
    guard let baseUrl = serverUrlsService.getLastAccessedUrl() else { fatalError("No last accessed url") }
    let serviceInstance = serviceType.init(baseUrl: baseUrl, version: .v4)
    return serviceInstance
  }
}
