//
//  SettingsViewModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2023/01/23.
//

import Foundation
import UIKit

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

    var settingsCellViewModels: [SettingsCellViewModel] = [
        SettingsCellViewModel(title: "ログアウト",
                              titleTextColor: #colorLiteral(red: 0.3790956736, green: 0.3788567185, blue: 0.3960185051, alpha: 1),
                              iconImage: UIImage(systemName: "rectangle.portrait.and.arrow.right") ?? .actions,
                              iconImageTintColor: #colorLiteral(red: 0.3790956736, green: 0.3788567185, blue: 0.3960185051, alpha: 1))
    ]
    
    func getCellViewModel(at indexPath: IndexPath) -> SettingsCellViewModel {
        return settingsCellViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {

    }
}
