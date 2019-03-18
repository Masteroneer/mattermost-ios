//
//  LoginView.swift
//  mattermost
//
//  Created by Vadim Salmin on 12/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class InputServerViewController: BaseViewController {
  @IBOutlet weak var topLabel: UILabel!
  
  private var theme: InputServerThemeProtocol? { return baseTheme as? InputServerThemeProtocol }
  
  private var presenter: InputServerPresenterProtocol? {
    return basePresenter as? InputServerPresenterProtocol
  }

  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: String(describing: InputServerViewController.self), bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func onEditingChangedUrl(_ sender: Any) {
    guard let urlTextField = sender as? UITextField,
      let text = urlTextField.text else { return }
    presenter?.onDidEndEditingUrl(text: text)
  }
  
  @IBAction func onNextBtnPressed(_ sender: Any) {
    presenter?.onNextPressed()
  }
}
