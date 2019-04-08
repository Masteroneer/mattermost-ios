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
  
  private let loggerGroupNameRequest = "API REQUEST"
  private let loggerGroupNameResponse = "API RESPONSE"
  
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
  
  func request(methodPathComponent: String?,
               method: HTTPMethod,
               headers: HTTPHeaders?,
               parameters: Parameters?,
               encoding: ParameterEncoding = URLEncoding.default) -> DataRequest {
    
    var url = getUrlForRequest() // getUrlWithServicePrefix()
    
    if let methodPathComponent = methodPathComponent {
      url = url.appendingPathComponent(methodPathComponent)
    }
    Logger.shared.printd(group: loggerGroupNameRequest,
                         "\nURL: \(url)",
                         "\nHeaders: \(String(describing: headers))",
                         "\nMethod: \(method)",
                         "\nParameters: \(String(describing: parameters))",
                         "\nEncoding: \(encoding)")
    let dataRequest =  Alamofire.request(url,
                                         method: method,
                                         parameters: parameters,
                                         encoding: encoding,
                                         headers: headers)
    dataRequest.responseString { [weak self] (response) in
      guard let strongSelf = self else { return }
      Logger.shared.printd(group: strongSelf.loggerGroupNameResponse,
                           "\nStatus: \(String(describing: response.response?.statusCode))",
                           "\nData: \(String(describing: response.result.value))")
    }
    return dataRequest
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
      
      // TODO: заюзать Alamofire enum Result
      do {
        let model = try JSONDecoder().decode(Model.self, from: resData)
        completion(.success(model))
      } catch {
        do {
          let model = try JSONDecoder().decode(ErrorModel.self, from: resData)
          completion(.failure(model))
        } catch {}
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
  
  func getUrlForRequest() -> URL {
    return baseUrl
            .appendingPathComponent(apiPathComponent)
            .appendingPathComponent(version.rawValue)
  }
  
  func getUrlWithServicePrefix() -> URL {
    var url =  baseUrl
                .appendingPathComponent(apiPathComponent)
                .appendingPathComponent(version.rawValue)
    
    url = url.appendingPathComponent(servicePathComponent)
    
    return url
  }
}
