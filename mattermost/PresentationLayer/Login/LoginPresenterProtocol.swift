//
//  LoginContract.swift
//  mattermost
//
//  Created by Вадим Салмин on 18.03.2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol: BasePresenterViewProtocol {
  func onChange(email: String)
  func onChange(password: String)
  func onPressLogin()
}
