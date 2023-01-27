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
    var logout: (() -> Void)?

    var alert: (title: String, msg: String, action: (() -> Void)?)? {
        didSet {
            self.presentAlert?()
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.toggleSVProgressHUD?()
        }
    }

    init() {}

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
        case .logout(_):
            // present logout? alert
            self.alert = ("ログアウトしますか？", "", self.firebaseLogout)
        }
    }

    func firebaseLogout() {
        guard FirebaseAuth.Auth.auth().currentUser != nil else {
            self.alert = ("エラー発生", AuthError.logoutError.message, nil)
            return
        }
        self.isLoading = true
        do {
            try FirebaseAuth.Auth.auth().signOut()
            self.isLoading = false
            self.goLoginScreen()
            return
        } catch {
            self.isLoading = false
            self.alert = ("エラー発生", AuthError.logoutError.message, nil)
            return
        }
    }

    func goLoginScreen() {
        let viewController = LoginViewController()
        UIApplication.shared.windows.first?.rootViewController = viewController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
