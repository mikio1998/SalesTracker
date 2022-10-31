//
//  LoginViewController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/31.
//

import UIKit

protocol LoginPresenterLike: AnyObject {
    
}

final class LoginViewController: UIViewController {
    
    private let viewContainer: LoginViewLike
//    private let model:
//    private var data: ?
    
    init(viewContainer: LoginViewLike = LoginView()) {
        self.viewContainer = viewContainer
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
    }
}

extension LoginViewController: LoginPresenterLike {}
