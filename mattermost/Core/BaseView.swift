//
//  BaseView.swift
//  mattermost
//
//  Created by Vadim Salmin on 15/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

// TODO: зависимость от UIKit
protocol BaseThemeProtocol {
  var backgroundColor: UIColor { get }
  init()
}


// TODO: Нужен ли он?
protocol BaseViewProtocol: class {
  var basePresenter: BasePresenterProtocol? { get set }
  var baseTheme: BaseThemeProtocol? { get set }
}
