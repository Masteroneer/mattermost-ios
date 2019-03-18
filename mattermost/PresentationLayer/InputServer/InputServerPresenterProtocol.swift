//
//  InputServerContract.swift
//  mattermost
//
//  Created by Vadim Salmin on 15/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation

protocol InputServerPresenterProtocol: BasePresenterViewProtocol {
  func onDidEndEditingUrl(text: String)
  func onNextPressed()
}
