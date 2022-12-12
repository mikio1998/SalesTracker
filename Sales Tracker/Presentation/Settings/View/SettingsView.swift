//
//  SettingsView.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/11/01.
//

import Foundation
import UIKit

protocol SettingsViewLike: ViewContainer {
    var presenterLike: SettingsPresenterLike? { get set }
    func setSnapshot(_ snapshot: SettingsSnapshot)
}

final class SettingsView: XibView {
    private typealias DataSource = UITableViewDiffableDataSource<Int, SettingsTableCellType>
    private lazy var dataSource: DataSource = {
        .init(tableView: tableView, cellProvider: cellProvider)
    }()
    
    private lazy var cellProvider: DataSource.CellProvider = { tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsTableViewCell", for: indexPath) as! SettingsTableViewCell
        switch item {
        case .logout(let model):
            cell.setUpCell(title: model.title, image: model.icon)
        }
        return cell
    }
    
    weak var presenterLike: SettingsPresenterLike?
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.register(UINib(nibName: "SettingsTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingsTableViewCell")
            self.tableView.isScrollEnabled = false
        }
    }
    
    init() {
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SettingsView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenterLike?.didSelectIndexPath(indexPath)
    }
}

extension SettingsView: SettingsViewLike {
    func setSnapshot(_ snapshot: SettingsSnapshot) {
        dataSource.apply(snapshot)
    }
}
