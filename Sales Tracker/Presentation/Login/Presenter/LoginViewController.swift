//
//  LoginViewController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/31.
//

import UIKit
import SVProgressHUD

protocol LoginPresenterLike: AnyObject {
    func didTapCreateAccBtn()
    func didTapLoginBtn(email: String?, pass: String?)
}

final class LoginViewController: UIViewController {
    
    private let viewContainer: LoginViewLike
    private let model: LoginModel
    
    init(viewContainer: LoginViewLike = LoginView(), model: LoginModel = LoginModelImpl()) {
        self.viewContainer = viewContainer
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = viewContainer.view
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewContainer.presenterLike = self
        viewContainer.setHelloTitle(model.helloTitle)
        viewContainer.setHelloTitle(model.backgroundImgUrl)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if model.isAlreadyLoggedIn {
//            self.goMainTabBar()
        }
    }
}

extension LoginViewController: LoginPresenterLike {
    func didTapCreateAccBtn() {
        UIAlertController(title: "アカウント作成については、", message: "21nakatam@gmail.comへお問い合わせください！", preferredStyle: .alert).addOK().show(fromVC: self)
    }
    
    func didTapLoginBtn(email: String?, pass: String?) {
        SVProgressHUD.show()
        guard let email = email, let pass = pass, !email.isEmpty, !pass.isEmpty else {
            SVProgressHUD.dismiss()
            UIAlertController(title: nil, message: LoginError.emptyFieldError.message, preferredStyle: .alert).addOK().show(fromVC: self)
            return
        }

        model.signIn(email: "21nakatam@gmail.com", pass: "tester") { result in
//        model.signIn(email: email, pass: pass) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .failure(let loginErr):
                UIAlertController(title: "エラー", message: loginErr.message, preferredStyle: .alert).addOK().show(fromVC: self)
            case .success(()):
                self.goMainTabBar()
            }
        }
    }
    
    func goMainTabBar() {
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "MainTabBarController", bundle: nil)
                let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
                UIApplication.shared.windows.first?.rootViewController = viewController
                UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}
