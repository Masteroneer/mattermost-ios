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
  
  // MARK: - private
  
  private let loggerGroupName = "API"
  
  private func request(methodPathComponent: String?, method: HTTPMethod, headers: HTTPHeaders, parameters: Parameters?) -> DataRequest {
    var url = getUrlWithServicePrefix()
    
    if let methodPathComponent = methodPathComponent {
      url.appendPathComponent(methodPathComponent)
    }
    
    return AF.request(url,
                       method: method,
                       parameters: parameters,
                       encoding: JSONEncoding.default,
                       headers: headers)
  }
  
  // MARK: - public
  
  public func isAuthorized() -> Bool {
    return getCookies() != nil
  }
  
  // MARK: - internal
  
  var baseUrl: URL
  var version: ApiVersion
  
  var apiPathComponent: String { return "api" }
  var servicePathComponent: String {
    fatalError("Must be implemented")
  }
  
  required init(baseUrl: URL, version: ApiVersion) {
    self.baseUrl = baseUrl
    self.version = version
  }
  
  ///
  /// Request without auth
  ///
  func request(methodPathComponent: String, method: HTTPMethod, parameters: Parameters?) -> DataRequest {
    let url = getUrlWithServicePrefix().appendingPathComponent(methodPathComponent)
    Logger.shared.printd(group: loggerGroupName, url, method, parameters ?? "")
    return AF.request(url,
                              method: method,
                              parameters: parameters,
                              encoding: JSONEncoding.default,
                              headers: nil)
  }
  
  
  /// Request with auth cookies, saved with saveCookies method
  ///
  func authorizedRequest(methodPathComponent: String?, method: HTTPMethod, parameters: Parameters?) -> DataRequest {
    guard let cookies = getCookies() else { fatalError("No cookies for selected url") }
    var url = getUrlWithServicePrefix()
    
    if let methodPathComponent = methodPathComponent {
      url = url.appendingPathComponent(methodPathComponent)
    }
    
    var headers: [String: String] = HTTPCookie.requestHeaderFields(with: cookies)
    headers["X-Requested-With"] = "XMLHttpRequest" // MAGIC: без этого хедера не работает (без магии жизнь была бы скучной)
    Logger.shared.printd(group: loggerGroupName, url, headers, method, parameters ?? "")
    return AF.request("https://httpbin.org/get")
    //    return AF.request(url,
//                      method: method,
//                      parameters: parameters,
//                      headers: headers)
  }
  
  /// Additional to authorizedRequest.
  /// Request can be serialize responsed data to type that conforms Codable
  func serializableAuthorizedRequest<Model: Codable>(methodPathComponent: String,
                                                               method: HTTPMethod,
                                                               parameters: Parameters?) -> ApiResult<Model, ErrorModel> {
    let result = ApiResult<Model, ErrorModel>()
    authorizedRequest(methodPathComponent: methodPathComponent, method: method, parameters: parameters).responseData { (res) in
      guard let resData = res.data,
          let status = res.response?.statusCode else { return }
      
      if status == 200 {
        let model = try! JSONDecoder().decode(Model.self, from: resData)
        result.send(success: model)
      } else {
        let model = try! JSONDecoder().decode(ErrorModel.self, from: resData)
        result.send(error: model)
      }
      }.responseDecodable { (response: DataResponse<Model>) in
        print(response)
    }
    return result
  }
  
  func saveCookies(from headers: [String: String]) {
    let cookies = HTTPCookie.cookies(withResponseHeaderFields: headers, for: baseUrl)
    HTTPCookieStorage.shared.setCookies(cookies, for: baseUrl, mainDocumentURL: nil)
  }
  
  func getCookies() -> [HTTPCookie]? {
    return HTTPCookieStorage.shared.cookies(for: baseUrl)
  }
  
  func getUrlWithServicePrefix() -> URL {
    return baseUrl
        .appendingPathComponent(apiPathComponent)
        .appendingPathComponent(version.rawValue)
        .appendingPathComponent(servicePathComponent)
  }
}
