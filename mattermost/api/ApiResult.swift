//
//  ApiResult.swift
//  mattermost
//
//  Created by user on 26/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

// TODO: Надо как то разграничить отправку и прием
class ApiResult<Success, Error> {
  typealias SuccessClosure = (Success) -> Void
  typealias ErrorClosure = (Error) -> Void
  
  private var successClosure: SuccessClosure?
  private var errorClosure: ErrorClosure?
  
  // MARK: - Subscribe methods
  
  @discardableResult
  func onSuccess(closure: @escaping (Success) -> Void) -> Self {
    successClosure = closure
    return self
  }
  
  @discardableResult
  func onError(closure: @escaping (Error) -> Void) -> Self {
    errorClosure = closure
    return self
  }
  
  // MARK: - Send messages
  
  func send(success result: Success) {
    guard let successClosure = successClosure else { return }
    successClosure(result)
  }
  
  func send(error result: Error) {
    guard let errorClosure = errorClosure else { return }
    errorClosure(result)
  }
}
