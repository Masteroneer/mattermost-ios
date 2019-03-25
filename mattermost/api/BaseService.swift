//
//  API.swift
//  mattermost
//
//  Created by Вадим on 14/02/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import Alamofire

enum ApiVersion: String {
  case v4
}

protocol BaseServiceProtocol {
  func isAuthorized() -> Bool
}

class BaseService: BaseServiceProtocol {
  
  // MARK: - public
  
  func isAuthorized() -> Bool {
    return getCookies() != nil
  }
  
  // MARK: - internal
  
  internal var baseUrl: URL
  internal var version: ApiVersion
  
  internal var apiPathComponent: String { return "api" }
  internal var servicePathComponent: String {
    fatalError("Must be implemented")
  }
  
  required init(baseUrl: URL, version: ApiVersion) {
    self.baseUrl = baseUrl
    self.version = version
  }

  ///
  /// Request without auth
  ///
  internal func request(methodPathComponent: String, method: HTTPMethod, parameters: Parameters?) -> DataRequest {
    let url = getUrlWithServicePrefix().appendingPathComponent(methodPathComponent)
    return Alamofire.request(url,
                              method: method,
                              parameters: parameters,
                              encoding: JSONEncoding.default,
                              headers: nil)
  }
  
  
  /// Request with auth cookies, saved with saveCookies method
  ///
  internal func authorizedRequest(methodPathComponent: String, method: HTTPMethod, parameters: Parameters?) -> DataRequest {
    guard let cookies = getCookies() else { fatalError("No cookies for selected url") }
    let url = getUrlWithServicePrefix().appendingPathComponent(methodPathComponent)
    var headers: HTTPHeaders = HTTPCookie.requestHeaderFields(with: cookies)
    headers["X-Requested-With"] = "XMLHttpRequest" // MAGIC: без этого хедера не работает (без магии жизнь была бы скучной)
    return Alamofire.request(url,
                              method: method,
                              parameters: parameters,
                              headers: headers)
  }
  
  /// Additional to authorizedRequest.
  /// Request can be serialize responsed data to Codable
  internal func serializableAuthorizedRequest<Model: Codable>(methodPathComponent: String,
                                                               method: HTTPMethod,
                                                               parameters: Parameters?,
                                                               completion: @escaping (Model) -> Void) {
    authorizedRequest(methodPathComponent: methodPathComponent, method: method, parameters: parameters).responseJSON { (res) in
      guard let resData = res.data else { return }
      
      let model = try! JSONDecoder().decode(Model.self, from: resData)

      completion(model)
    }
  }
  
  internal func saveCookies(from headers: HTTPHeaders) {
    let cookies = HTTPCookie.cookies(withResponseHeaderFields: headers, for: baseUrl)
    HTTPCookieStorage.shared.setCookies(cookies, for: baseUrl, mainDocumentURL: nil)
  }
  
  internal func getCookies() -> [HTTPCookie]? {
    return HTTPCookieStorage.shared.cookies(for: baseUrl)
  }
  
  internal func getUrlWithServicePrefix() -> URL {
    return baseUrl
        .appendingPathComponent(apiPathComponent)
        .appendingPathComponent(version.rawValue)
        .appendingPathComponent(servicePathComponent)
  }
}
