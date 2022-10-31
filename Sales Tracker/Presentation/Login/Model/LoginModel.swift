//
//  LoginModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/31.
//

import Foundation
import FirebaseAuth

protocol LoginModel {
    var isAlreadyLoggedIn: Bool { get }
    func signIn(email: String, pass: String, completion: @escaping (Result<(), LoginError>) -> ())
}

final class LoginModelImpl: LoginModel {
    var isAlreadyLoggedIn: Bool {
        if FirebaseAuth.Auth.auth().currentUser != nil {
            return true
        } else {
            return false
        }
    }
    
    func signIn(email: String, pass: String, completion: @escaping (Result<(), LoginError>) -> ()) {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: pass) { result, err in
            if err != nil {
                completion(.failure(LoginError.loginError))
            } else {
                completion(.success(()))
            }
        }
    }
}
