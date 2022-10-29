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
    func noResults(error: FirestoreError?)
}

final class SalesHistoryView: XibView {
    private typealias DataSource = UITableViewDiffableDataSource<Int, SalesHistoryTableSnapshotDataModel>
    private lazy var dataSource: DataSource = {
        .init(tableView: tableView, cellProvider: cellProvider)
    }()
    private lazy var cellProvider: DataSource.CellProvider = { tableView, indexPath, item in
        let cell = tableView.dequeueReusableCell(withIdentifier: "SalesHistoryTableViewCell", for: indexPath) as! SalesHistoryTableViewCell
        cell.setUpCell(model: item)
        return cell
    }
    
    weak var presenterLike: SalesHistoryPresenterLike?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reloadButton: UIView!
    @IBOutlet weak var reloadButtonLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.separatorStyle = .none
            tableView.register(UINib(nibName: "SalesHistoryTableViewCell", bundle: nil), forCellReuseIdentifier: "SalesHistoryTableViewCell")
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
        130
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            guard let id = self.dataSource.itemIdentifier(for: indexPath)?.soldProductItem.id else { return }
            
            FirestoreManager.deleteSaleEntry(id: id) { result in
                switch result {
                case .failure(let fireErr):
                    print("fail")
                    // TODO: Error alert!!
                case .success():
                    self.presenterLike?.reloadData()
                }
            }
            completionHandler(true)
        }

        let edit = UIContextualAction(style: .normal, title: "Edit") { (action, sourceView, completionHandler) in
            self.presenterLike?.didSelectEditFor(indexPath)
            completionHandler(true)
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete, edit])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
    
    
}

extension SalesHistoryView: SalesHistoryViewLike {
    func setSnapshot(_ snapshot: SalesHistorySnapshot) {
        dataSource.apply(snapshot)
    }
    // MARK: LEft off here!!
    //  Is the no results alpha working?
    //  Screw up the data and see if it shows.
    
    func noResults(error: FirestoreError?) {
        tableView.alpha = 0
        noResultsView.alpha = 1
        noResultLabel.alpha = 1
        noResultLabel.text = error != nil ? error?.message : "検索結果がありません。"
    }
}
