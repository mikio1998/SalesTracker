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
    func setHelloTitle(_ text: String)
    func setBackgroundImg(withURL: String)
}

final class LoginView: XibView {
    
    weak var presenterLike: LoginPresenterLike?
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    @IBOutlet weak var helloLabel: UILabel!
    
    @IBOutlet weak var greenView: UIView!
    
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
        backgroundImage.contentMode = .scaleAspectFill
        DispatchQueue.main.async {
            self.greenView.roundCorners(for: [.topRight], radius: 45)
            self.whiteView.roundCorners(for: [.topRight], radius: 45)
            self.loginButton.roundCorners(for: .allCorners, radius: 5)
//            self.emailField.giveShadow()
        }
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


extension LoginView: LoginViewLike {
    func setHelloTitle(_ text: String) {
        self.helloLabel.text = text
    }
    func setBackgroundImg(withURL urlStr: String) {
        backgroundImage.loadImage(with: urlStr)
    }
}
