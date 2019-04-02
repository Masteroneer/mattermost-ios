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
  init(baseUrl: URL, version: ApiVersion)
  func isAuthorized() -> Bool
}

class BaseService: BaseServiceProtocol {
  
  // MARK: - private
  
  private let loggerGroupName = "API"
  
  // MARK: - public
  
  public func isAuthorized() -> Bool {
    return getCookies() != nil
  }
  
  // MARK: - internal
  
  var baseUrl: URL
  var version: ApiVersion
  
  var apiPathComponent: String { return "api" }
  var myServicePathComponent: String { return "users/me" } // TODO: #line 123
  var isMyRequest: Bool = false // TODO: #line 123
  var servicePathComponent: String {
    fatalError("Must be implemented")
  }
  
  required init(baseUrl: URL, version: ApiVersion) {
    self.baseUrl = baseUrl
    self.version = version
  }
  
  func request(methodPathComponent: String?,
               method: HTTPMethod,
               headers: HTTPHeaders?,
               parameters: Parameters?,
               encoding: ParameterEncoding = URLEncoding.default) -> DataRequest {
    
    var url = getUrlWithServicePrefix()
    
    if let methodPathComponent = methodPathComponent {
      url = url.appendingPathComponent(methodPathComponent)
    }
    Logger.shared.printd(group: loggerGroupName, url, headers ?? "", method, parameters ?? "", encoding)
    return Alamofire.request(url,
                             method: method,
                             parameters: parameters,
                             encoding: encoding,
                             headers: headers)
  }
  
  
  /// Request with auth cookies, saved with saveCookies method
  ///
  func authorizedRequest(methodPathComponent: String?,
                         method: HTTPMethod,
                         parameters: Parameters?,
                         encoding: ParameterEncoding = URLEncoding.default) -> DataRequest {
    
    guard let cookies = getCookies() else { fatalError("No cookies for selected url") }
    var headers: HTTPHeaders = HTTPCookie.requestHeaderFields(with: cookies)
    headers["X-Requested-With"] = "XMLHttpRequest" // MAGIC: без этого хедера не работает (без магии жизнь была бы скучной)
    return request(methodPathComponent: methodPathComponent,
                   method: method,
                   headers: headers,
                   parameters: parameters,
                   encoding: encoding)
  }
  
  /// Additional to authorizedRequest.
  /// Request can be serialize responsed data to type that conforms Codable
  func serializableAuthorizedRequest<Model: Codable>(methodPathComponent: String?,
                                                     method: HTTPMethod,
                                                     parameters: Parameters?,
                                                     encoding: ParameterEncoding = URLEncoding.default,
                                                     completion: @escaping (ApiResult<Model, ErrorModel>) -> Void) {
    
    let dataRequest = authorizedRequest(methodPathComponent: methodPathComponent, method: method, parameters: parameters, encoding: encoding)
    dataRequest.responseData { (res) in
      guard let resData = res.data else { return }
      
      do {
        let model = try JSONDecoder().decode(Model.self, from: resData)
        completion(.success(model))
      } catch {
        let model = try! JSONDecoder().decode(ErrorModel.self, from: resData)
        completion(.failure(model))
      }
    }
  }
  
  func saveCookies(from headers: [String: String]) {
    let cookies = HTTPCookie.cookies(withResponseHeaderFields: headers, for: baseUrl)
    HTTPCookieStorage.shared.setCookies(cookies, for: baseUrl, mainDocumentURL: nil)
  }
  
  func getCookies() -> [HTTPCookie]? {
    return HTTPCookieStorage.shared.cookies(for: baseUrl)
  }
  
  func getUrlWithServicePrefix() -> URL {
    var url =  baseUrl
                .appendingPathComponent(apiPathComponent)
                .appendingPathComponent(version.rawValue)
    
    // TODO: - ДА ДА ЭТО КОСТЫЛЬ, НУ ЧТО ПОДЕЛАТЬ БЕЗ ЭТОГО НИКУДА
    if isMyRequest {
      url = url.appendingPathComponent(myServicePathComponent)
    }
    
    url = url.appendingPathComponent(servicePathComponent)
    
    return url
  }
}
