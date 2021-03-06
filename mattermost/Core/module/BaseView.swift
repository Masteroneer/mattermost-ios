//
//  BaseView.swift
//  mattermost
//
//  Created by Vadim Salmin on 15/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

protocol BaseViewProtocol: BaseViewPresenterProtocol, TransitionHandlerProtocol {
  var basePresenter: BasePresenterViewProtocol? { get set }
  //var baseThemeFactory: BaseThemeProtocol? { get set }
}

// Protocol to interact presenter with view
protocol BaseViewPresenterProtocol: class {}
