//
//  LoginViewController.swift
//  mattermost
//
//  Created by Vadim Salmin on 13/03/2019.
//  Copyright © 2019 Vadim Salmin. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewProtocol: BaseViewProtocol {
  func setErrorMessage(_ message: String)
}

final class LoginViewController: BaseViewController, LoginViewProtocol {
  private var presenter: LoginPresenterProtocol? { return basePresenter as? LoginPresenterProtocol }
  
  @IBOutlet weak var errorLabel: UILabel!
  
  @IBAction func emailEditingChanged(_ sender: Any) {
    guard let emailTextField = sender as? UITextField,
      let email = emailTextField.text else { return }
    
    presenter?.onChange(email: email)
  }
  
  @IBAction func passwordEditingChanged(_ sender: Any) {
    guard let passwordTextField = sender as? UITextField,
      let password = passwordTextField.text else { return }
    
    presenter?.onChange(password: password)
  }
  
  @IBAction func onLoginPressed(_ sender: Any) {
    presenter?.onPressLogin()
  }
  
  // MARK: - Login View Protocol
  
  func setErrorMessage(_ message: String) {
    errorLabel.text = message
  }
}
