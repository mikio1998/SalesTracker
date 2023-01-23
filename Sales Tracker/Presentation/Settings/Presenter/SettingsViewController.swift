//
//  SettingsViewController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/11/01.
//

import UIKit
import SVProgressHUD

final class SettingsViewController: UIViewController {
    // outlets

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
    }

    func initViewModel() {
        // Present alert
        viewModel.presentAlert = { [weak self] in
            guard let self = self else { return }
            UIAlertController(title: self.viewModel.alert?.title, message: self.viewModel.alert?.msg, preferredStyle: .alert)
                .addOK()
                .show(fromVC: self)
        }

        // Toggle SVProgressHUD
        viewModel.toggleSVProgressHUD = { [weak self] in
            self?.viewModel.isLoading == true ? SVProgressHUD.show() : SVProgressHUD.dismiss()
        }
    }

}

//protocol SettingsPresenterLike: AnyObject {
//    func didSelectIndexPath(_ indexPath: IndexPath)
//}
//
//final class SettingsViewController: UIViewController {
//    private let viewContainer: SettingsViewLike
//    private let model: SettingsModel
//
//    init(viewContainer: SettingsViewLike = SettingsView(), model: SettingsModel = SettingsModelImpl()) {
//        self.viewContainer = viewContainer
//        self.model = model
//        super.init(nibName: nil, bundle: Bundle(for: Self.self))
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func loadView() {
//        self.view = viewContainer.view
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        viewContainer.presenterLike = self
//        viewContainer.setSnapshot(model.settingsSnapshot)
//    }
//}
//extension SettingsViewController: SettingsPresenterLike {
//    func didSelectIndexPath(_ indexPath: IndexPath) {
//        let cellModel = model.settingsSnapshot.itemIdentifiers(inSection: 0)[indexPath.row]
//        switch cellModel {
//        case .logout:
//            UIAlertController(title: "ログアウトしますか？", message: nil, preferredStyle: .alert)
//                .addOK { _ in
//                    self.signOut()
//                }.addCancel()
//                .show(fromVC: self)
//        }
//    }
//
//    private func signOut() {
//        self.model.signOut { result in
//            switch result {
//            case .failure:
//                DispatchQueue.main.async {
//                    UIAlertController(title: "エラー", message: "ログアウトが失敗しました。", preferredStyle: .alert).addOK().show(fromVC: self)
//                }
//            case .success(()):
//                self.goLoginScreen()
//            }
//        }
//        self.goLoginScreen()
//    }
//
//    func goLoginScreen() {
//        let viewController = LoginViewController()
//        UIApplication.shared.windows.first?.rootViewController = viewController
//        UIApplication.shared.windows.first?.makeKeyAndVisible()
//    }
//}
