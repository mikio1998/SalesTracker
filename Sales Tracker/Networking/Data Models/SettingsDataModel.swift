//
//  SettingsDataModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/11/01.
//

import Foundation
import UIKit

//typealias SettingsSnapshot = NSDiffableDataSourceSnapshot<Int, SettingsTableSnapshotDataModel>
typealias SettingsSnapshot = NSDiffableDataSourceSnapshot<Int, SettingsTableCellType>

enum SettingsTableCellType: Hashable {
    case logout(LogoutDataModel)
}

struct LogoutDataModel: Hashable {
    let title: String
    let icon: UIImage
    let backgroundColor: UIColor
}


//
//struct SettingsTableSnapshotDataModel: Hashable {
//    let title: String
//    let icon: UIImage
//    let backgroundColor: UIColor
//}
