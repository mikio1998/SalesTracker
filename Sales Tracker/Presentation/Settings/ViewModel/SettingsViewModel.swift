//
//  SettingsViewModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2023/01/23.
//

import Foundation

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

    var settingsCellViewModels = [SettingsCellViewModel]() {
//        didSet {
//            if salesHistoryCellViewModels.isEmpty {
//                self.showNoResults?(nil)
//            } else {
//                self.reloadTableView?()
//            }
//            self.isLoading = false
//        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> SettingsCellViewModel {
        return settingsCellViewModels[indexPath.row]
    }

    func didSelectRow(at indexPath: IndexPath) {

    }
}
