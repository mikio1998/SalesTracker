//
//  SalesHistoryView.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/21.
//

import Foundation
import UIKit

protocol SalesHistoryViewLike: ViewContainer {
    var presenterLike: SalesHistoryPresenterLike? { get set }
    func setSnapshot(_ snapshot: SalesHistorySnapshot)
    func setTitle(_ text: String)
    func noResults(error: FirestoreError?)
}

final class SalesHistoryView: XibView {
    private typealias DataSource = UITableViewDiffableDataSource<Int, SalesHistoryTableSnapshotDataModel>
    private lazy var dataSource: DataSource = {
        .init(tableView: tableView, cellProvider: cellProvider)
    }()
    private lazy var cellProvider: DataSource.CellProvider = { tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: Const.salesHistoryTableViewCellClassName, for: indexPath) as! SalesHistoryTableViewCell
        cell.setUpCell(model: item)
        return cell
    }
    
    weak var presenterLike: SalesHistoryPresenterLike?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reloadButton: UIView!
    @IBOutlet weak var reloadButtonLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.separatorStyle = .none
            self.tableView.register(UINib(nibName: Const.salesHistoryTableViewCellClassName, bundle: nil), forCellReuseIdentifier: Const.salesHistoryTableViewCellClassName)
        }
    }
    @IBOutlet weak var noResultsView: UIView!
    @IBOutlet weak var noResultLabel: UILabel!
    
    init() {
        super.init(frame: .zero)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizerAction))
        self.reloadButton.addGestureRecognizer(tapGesture)
        self.reloadButton.giveRoundCorners(withCornerRadius: 20)
    }
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func tapGestureRecognizerAction(sender: UITapGestureRecognizer) {
        presenterLike?.reloadData()
    }
}
extension SalesHistoryView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Const.tableViewRowHeight
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "削除") { (action, sourceView, completionHandler) in
            self.presenterLike?.didSelectDeleteFor(indexPath)
            completionHandler(true)
        }
        let edit = UIContextualAction(style: .normal, title: "編集") { (action, sourceView, completionHandler) in
            self.presenterLike?.didSelectEditFor(indexPath)
            completionHandler(true)
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete, edit])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
}

extension SalesHistoryView: SalesHistoryViewLike {
    func setTitle(_ text: String) {
        self.titleLabel.text = text
    }
    func setSnapshot(_ snapshot: SalesHistorySnapshot) {
        dataSource.apply(snapshot, animatingDifferences: false, completion: nil)
    }
    func noResults(error: FirestoreError?) {
        tableView.alpha = 0
        noResultsView.alpha = 1
        noResultLabel.alpha = 1
        noResultLabel.text = error != nil ? error?.message : "検索結果がありません。"
    }
}

extension SalesHistoryView {
    private enum Const {
        static let salesHistoryTableViewCellClassName: String = "SalesHistoryTableViewCell"
        static let tableViewRowHeight: CGFloat = 130
    }
}
