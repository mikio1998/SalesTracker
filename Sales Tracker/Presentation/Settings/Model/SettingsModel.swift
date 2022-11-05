//
//  SettingsModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/11/01.
//

import Foundation
import FirebaseAuth
import UIKit

protocol SettingsModel {
    var settingsSnapshot: SettingsSnapshot { get }
    func signOut(completion: @escaping (Result<(), AuthError>) -> ())
}

final class SettingsModelImpl: SettingsModel {
    var settingsSnapshot: SettingsSnapshot {
        var snap = SettingsSnapshot()
        snap.appendSections([0])
        
        let logoutModel = LogoutDataModel(
            title: "ログアウト",
            icon: UIImage(systemName: "rectangle.portrait.and.arrow.right") ?? .actions,
            backgroundColor: .white)
        
        snap.appendItems([.logout(logoutModel)], toSection: 0)
        return snap
    }
    func signOut(completion: @escaping (Result<(), AuthError>) -> ()) {
        guard FirebaseAuth.Auth.auth().currentUser != nil else {
            completion(.failure(AuthError.logoutError))
            return
        }
        do {
            try FirebaseAuth.Auth.auth().signOut()
            completion(.success(()))
        } catch {
            completion(.failure(AuthError.logoutError))
        }
    }
}


// MARK: left off here
//  make log out btn work, somewhere
