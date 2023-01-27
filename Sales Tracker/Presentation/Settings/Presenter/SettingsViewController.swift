//
//  SettingsViewController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/11/01.
//
// Left off: MVVM SettingsVC
//      Just see what else

import UIKit
import SVProgressHUD

final class SettingsViewController: UIViewController {
    // outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    lazy var viewModel = {
        SettingsViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }

    func initView() {
        // Tableview
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(SettingsTableViewCell.nib, forCellReuseIdentifier: SettingsTableViewCell.identifier)
        self.tableView.isScrollEnabled = false
        self.adjustDarkMode()
    }

    func initViewModel() {
        // Present alert
        viewModel.presentAlert = { [weak self] in
            guard let self = self else { return }
            UIAlertController(title: self.viewModel.alert?.title, message: self.viewModel.alert?.msg, preferredStyle: .alert)
//                .addOK()
                .addOK { _ in
                    self.viewModel.alert?.action?()
                }
                .addCancel()
                .show(fromVC: self)
        }

        // Toggle SVProgressHUD
        viewModel.toggleSVProgressHUD = { [weak self] in
            self?.viewModel.isLoading == true ? SVProgressHUD.show() : SVProgressHUD.dismiss()
        }
    }

    func adjustDarkMode() {
        // backView
        if self.traitCollection.userInterfaceStyle == .dark {
            self.backView.backgroundColor = .black
        }
        // title
        if self.traitCollection.userInterfaceStyle == .dark {
            self.titleLabel.textColor = .white
        } else {
            self.titleLabel.textColor = #colorLiteral(red: 0.3790956736, green: 0.3788567185, blue: 0.3960185051, alpha: 1)
        }
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.settingsCellViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = self.viewModel.getCellViewModel(at: indexPath)

        switch cellType {
        // Basic cells use SettingsTableViewCell
        case .logout(let logoutModel):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
                fatalError("xib does not exist")
            }
            cell.setUpCell(vm: logoutModel)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.didSelectRow(at: indexPath)
    }
}
