//
//  SalesHistoryViewController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/21.
//

import UIKit
import SVProgressHUD

protocol SalesHistoryViewControllerDelegate: AnyObject {
    func reloadData()
}

final class SalesHistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reloadButton: UIView!
    @IBOutlet weak var reloadButtonLabel: UILabel!
    @IBOutlet weak var noResultsView: UIView!
    @IBOutlet weak var noResultsLabel: UILabel!
    
    lazy var viewModel = {
        SalesHistoryViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        reloadData()
    }
    
    func initView() {
        // Tableview
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(SalesHistoryTableViewCell.nib, forCellReuseIdentifier: SalesHistoryTableViewCell.identifier)
        titleLabel.text = "在庫補充"
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
        self.reloadButton.addGestureRecognizer(tapGesture)
        self.reloadButton.giveRoundCorners(withCornerRadius: 20)
    }
    @objc func tapGestureRecognizerAction(sender: UITapGestureRecognizer) {
        reloadData()
    }
    
    
    func initViewModel() {
        // Reload tableView closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
                self?.tableView.reloadData()
            }
        }
        
        // Update title count
        viewModel.updateTitleCount = { [weak self] count in
            DispatchQueue.main.async {
                self?.titleLabel.text = "在庫補充 (\(count)点)"
            }
        }
        
        // Present alert
        viewModel.presentAlert = { [weak self] title, msg in
            guard let self = self else { return }
            UIAlertController(title: "失敗", message: msg, preferredStyle: .alert)
                .addOK()
                .show(fromVC: self)
        }
        
        // Show no results
        viewModel.showNoResults = { [weak self] error in
            DispatchQueue.main.async {
                self?.tableView.alpha = 0
                self?.noResultsView.alpha = 1
                self?.noResultsLabel.alpha = 1
                self?.noResultsLabel.text = error != nil ? error?.message : "検索結果がありません。"
            }
        }
        
        // Present Edit Quantity VC
        viewModel.presentEditQuantityVC = { [weak self] item in
            guard let self = self else { return }
            let editQuantityVC = EditQuantityViewController(soldItem: item, salesHistoryDelegate: self)
            editQuantityVC.modalPresentationStyle = .custom
            editQuantityVC.transitioningDelegate = self
            self.present(editQuantityVC, animated: true, completion: nil)
        }
        
        // Get sales history data
        reloadData()
    }
}

extension SalesHistoryViewController: SalesHistoryViewControllerDelegate {
    func reloadData() {
        SVProgressHUD.show() // Dismissed in reload tableView closure.
        self.viewModel.getSalesHistory()
    }
}

extension SalesHistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.salesHistoryCellViewModels.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SalesHistoryTableViewCell.identifier, for: indexPath) as? SalesHistoryTableViewCell else {
            fatalError("xib does not exist")
        }
        let cellVM = self.viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Const.tableViewRowHeight
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "削除") { (action, sourceView, completionHandler) in
            self.viewModel.didSelectDeleteFor(indexPath)
            completionHandler(true)
        }
        let edit = UIContextualAction(style: .normal, title: "編集") { (action, sourceView, completionHandler) in
            self.viewModel.didSelectEditFor(indexPath)
            completionHandler(true)
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete, edit])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
}

extension SalesHistoryViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension SalesHistoryViewController {
    private enum Const {
        static let tableViewRowHeight: CGFloat = 130
    }
}
