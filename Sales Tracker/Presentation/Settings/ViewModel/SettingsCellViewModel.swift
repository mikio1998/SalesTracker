//
//  SettingsCellViewModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2023/01/23.
//

import Foundation
import UIKit

// Cell types
enum SettingsTableCellType: Hashable {
    case logout(LogoutCellViewModel)
    // Any other cells...
}

// Basic cell template
protocol SettingsCellViewModel {
    var title: String { get }
    var titleTextColor: UIColor { get }
    var iconImage: UIImage { get }
    var iconImageTintColor: UIColor { get }
}

struct LogoutCellViewModel: SettingsCellViewModel, Hashable {
    var title: String
    var titleTextColor: UIColor
    var iconImage: UIImage
    var iconImageTintColor: UIColor
}
