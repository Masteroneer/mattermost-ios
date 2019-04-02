//
//  ApiResult.swift
//  mattermost
//
//  Created by user on 26/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

enum ApiResult<S, E> {
  case success(S)
  case failure(E)
}
