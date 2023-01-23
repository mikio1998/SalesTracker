//
//  SettingsViewModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2023/01/23.
//

import Foundation
import UIKit
import FirebaseAuth

class SettingsViewModel {
    var presentAlert: (() -> Void)?

    var toggleSVProgressHUD: (() -> Void)?

    var alert: (title: String, msg: String)? {
        didSet {
            self.presentAlert?()
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.toggleSVProgressHUD?()
        }
    }

    init() {

    }

//    var settingsCellViewModels: [SettingsCellViewModel] = [
//        LogoutCellViewModel(title: "ログアウト",
//                              titleTextColor: #colorLiteral(red: 0.3790956736, green: 0.3788567185, blue: 0.3960185051, alpha: 1),
//                              iconImage: UIImage(systemName: "rectangle.portrait.and.arrow.right") ?? .actions,
//                              iconImageTintColor: #colorLiteral(red: 0.3790956736, green: 0.3788567185, blue: 0.3960185051, alpha: 1))
//    ]
    var settingsCellViewModels: [SettingsTableCellType] = [
        .logout(LogoutCellViewModel(title: "ログアウト",
                                    titleTextColor: #colorLiteral(red: 0.3790956736, green: 0.3788567185, blue: 0.3960185051, alpha: 1),
                                    iconImage: UIImage(systemName: "rectangle.portrait.and.arrow.right") ?? .actions,
                                    iconImageTintColor: #colorLiteral(red: 0.3790956736, green: 0.3788567185, blue: 0.3960185051, alpha: 1)))
    ]
    
    func getCellViewModel(at indexPath: IndexPath) -> SettingsTableCellType {
        return settingsCellViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {
        let cellModel = self.settingsCellViewModels[indexPath.row]
        switch cellModel {
        case .logout(let _):
            // perform logout
            self.firebaseLogout { [weak self] result in
                switch result {
                case .success(let _):
                    self?.alert = ("ログアウト完了", "")
                case .failure(let failure):
                    self?.alert = ("エラー発生", failure.message)
                }
            }
        }
    }

    func firebaseLogout(completion: @escaping (Result<(), AuthError>) -> Void) {
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
