//
//  LoginModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/31.
//

import Foundation
import FirebaseAuth

protocol LoginModel {
    var helloTitle: String { get }
    var isAlreadyLoggedIn: Bool { get }
    func signIn(email: String, pass: String, completion: @escaping (Result<(), LoginError>) -> ())
    var backgroundImgUrl: String { get }
}

final class LoginModelImpl: LoginModel {
    var helloTitle: String {
        return Hello(hour: Date().currentHoursAndMins.hours).title
    }
    var backgroundImgUrl: String {
        return "https://images.microcms-assets.io/assets/1775a3633c8b428d9f011c6a758a8a5c/6d7c315622b94651bb19cf48e610e49c/2004%20%E3%82%A2%E3%83%A1%E6%A8%AA%E5%BA%97.JPG?w=2400"
    }
    
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
