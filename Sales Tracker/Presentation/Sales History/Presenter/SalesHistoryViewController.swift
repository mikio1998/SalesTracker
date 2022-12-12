//
//  SalesHistoryViewController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/21.
//

import UIKit
import SVProgressHUD

protocol SalesHistoryPresenterLike: AnyObject {
    func reloadData()
    func didSelectDeleteFor(_ indexPath: IndexPath)
    func didSelectEditFor(_ indexPath: IndexPath)
}

protocol SalesHistoryViewControllerDelegate: AnyObject {
    func reloadData()
}

final class SalesHistoryViewController: UIViewController {
    private let viewContainer: SalesHistoryViewLike
    private let model: SalesHistoryModel
    private var data: SalesHistoryDataModel?
    
    init(viewContainer: SalesHistoryViewLike = SalesHistoryView(),
         model: SalesHistoryModel = SalesHistoryModelImpl()) {
        self.viewContainer = viewContainer
        self.model = model
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
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadData()
    }
    
    private func loadData() {
        SVProgressHUD.show()
        model.loadDataModel { result in
            SVProgressHUD.dismiss()
            switch result {
            case .failure(let fireErr):
                UIAlertController(title: "エラー発生", message: fireErr.message, preferredStyle: .alert)
                    .addOK()
                    .show(fromVC: self)
                self.viewContainer.noResults(error: fireErr)
            case .success(let dataModel):
                self.viewContainer.setSnapshot(dataModel.salesHistorySnapshot)
                self.viewContainer.setTitle("在庫補充　(\(dataModel.itemCount)点)")
                self.data = dataModel
            }
        }
    }
}

extension SalesHistoryViewController: SalesHistoryPresenterLike, SalesHistoryViewControllerDelegate {
    func reloadData() {
        self.loadData()
    }
    
    func didSelectDeleteFor(_ indexPath: IndexPath) {
        guard let prodId = data?.salesHistorySnapshot.itemIdentifiers(inSection: 0)[indexPath.row].soldProductItem.id else { return }
        
        FirestoreManager.deleteSaleEntry(id: prodId) { result in
            switch result {
            case .failure(let fireErr):
                UIAlertController(title: "失敗", message: fireErr.message, preferredStyle: .alert)
                    .addOK()
                    .show(fromVC: self)
            case .success():
                self.loadData()
            }
        }
    }
    
    func didSelectEditFor(_ indexPath: IndexPath) {
        guard let prod = data?.salesHistorySnapshot.itemIdentifiers(inSection: 0)[indexPath.row].soldProductItem else { return }
        let editQuantityVC = EditQuantityViewController(soldItem: prod, salesHistoryDelegate: self)
        editQuantityVC.modalPresentationStyle = .custom
        editQuantityVC.transitioningDelegate = self
        self.present(editQuantityVC, animated: true, completion: nil)
    }
}

extension SalesHistoryViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
