//
//  EditQuantityViewController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/28.
//

import UIKit
import SVProgressHUD

protocol EditQuantityPresenterLike: AnyObject {
    func dismissPresenter(animated: Bool)
    func didTapEditButton(item: SoldProductItem, count: Int)
}

final class EditQuantityViewController: UIViewController {
    private let viewContainer: EditQuantityViewLike
    private let salesHistoryDelegate: SalesHistoryViewControllerDelegate
    
    init(soldItem: SoldProductItem, salesHistoryDelegate: SalesHistoryViewControllerDelegate) {
        self.viewContainer = EditQuantityView(soldItem: soldItem)
        self.salesHistoryDelegate = salesHistoryDelegate
        super.init(nibName: nil, bundle: Bundle(for: Self.self))
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func loadView() {
        self.view = viewContainer.view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContainer.presenterLike = self
    }
}

extension EditQuantityViewController: EditQuantityPresenterLike {
    func dismissPresenter(animated: Bool) {
        self.dismiss(animated: true) {
            self.salesHistoryDelegate.reloadData()
        }
    }
    func didTapEditButton(item: SoldProductItem, count: Int) {
        guard let id = item.id else { return }
        SVProgressHUD.show()
        if count == 0 {
            FirestoreManager.deleteSaleEntry(id: id) {
                result in
                SVProgressHUD.dismiss()
                switch result {
                case .failure(let fireErr):
                    UIAlertController(title: "エラー発生", message: fireErr.message, preferredStyle: .alert)
                        .addOK()
                        .show(fromVC: self)
                    
                case .success(()):
                    UIAlertController(title: "削除！", message: nil, preferredStyle: .alert)
                        .showAndDismiss(fromVC: self, deadline: .now() + 0.7) {
                            self.dismissPresenter(animated: true)
                        }
                    
                }
            }
        } else {
            FirestoreManager.updateSaleCountForItem(id: id, newCount: count) { result in
                SVProgressHUD.dismiss()
                switch result {
                case .failure(let fireErr):
                    UIAlertController(title: "エラー発生", message: fireErr.message, preferredStyle: .alert)
                        .addOK()
                        .show(fromVC: self)
                case .success(()):
                    UIAlertController(title: "変更！", message: nil, preferredStyle: .alert)
                        .showAndDismiss(fromVC: self, deadline: .now() + 0.7) {
                            self.dismissPresenter(animated: true)
                        }
                }
                self.dismissPresenter(animated: true)
            }
        }
    }
}
