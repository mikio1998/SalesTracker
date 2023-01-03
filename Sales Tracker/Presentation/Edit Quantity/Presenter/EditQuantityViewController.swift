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
    func didTapEditButton(item: SoldProd, count: Int)
}

final class EditQuantityViewController: UIViewController {
    private let viewContainer: EditQuantityViewLike
    private let salesHistoryDelegate: SalesHistoryViewControllerDelegate
    // MARK: TODO model
    private let engine: NetworkEngine
    init(soldItem: SoldProd, salesHistoryDelegate: SalesHistoryViewControllerDelegate, engine: NetworkEngine = FirestoreManager.shared) {
        self.viewContainer = EditQuantityView(soldItem: soldItem)
        self.salesHistoryDelegate = salesHistoryDelegate
        self.engine = engine
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
    func didTapEditButton(item: SoldProd, count: Int) {
        let sku = item.prod.sku
        SVProgressHUD.show()
        if count == 0 {
            engine.deleteSaleEntry(sku: sku) { result in
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
            engine.updateSaleCountForItem(sku: sku, newCount: count) { result in
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
