//
//  LoginView.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/31.
//

import Foundation
import UIKit

protocol LoginViewLike: ViewContainer {
    var presenterLike: LoginPresenterLike? { get set }
}

final class LoginView: XibView {
    
    weak var presenterLike: LoginPresenterLike?
    
    @IBOutlet weak var helloLabel: UILabel!
    
    @IBOutlet weak var whiteView: UIView!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var loginButton: UIView!
    
    @IBOutlet weak var createAccountButton: UILabel!
    
    init() {
        super.init(frame: .zero)
        
        let loginTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapLoginButton))
        loginButton.addGestureRecognizer(loginTapGesture)
        
        
        let createAccTapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCreateAccButton))
        createAccountButton.addGestureRecognizer(createAccTapGesture)
        
        createAccountButton.isUserInteractionEnabled = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapLoginButton(sender: UITapGestureRecognizer) {
        presenterLike?.didTapLoginBtn(email: emailField.text, pass: passwordField.text)
    }
    
    @objc func didTapCreateAccButton(sender: UITapGestureRecognizer) {
        presenterLike?.didTapCreateAccBtn()
    }
        
        
        
    
}


extension LoginView: LoginViewLike {}
