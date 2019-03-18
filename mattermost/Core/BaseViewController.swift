//
//  BaseViewController.swift
//  mattermost
//
//  Created by Vadim Salmin on 18/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

class BaseViewController: UIViewController, BaseViewProtocol, BaseViewPresenterProtocol {
  var basePresenter: BasePresenterProtocol?
  var baseTheme: BaseThemeProtocol?
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    applyTheme()
  }
  
  func applyTheme() {
    guard let baseTheme = baseTheme else { return }
    
    view.backgroundColor = baseTheme.backgroundColor
  }
}
