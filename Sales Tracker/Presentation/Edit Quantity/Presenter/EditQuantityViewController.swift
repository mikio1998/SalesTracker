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
            print("Dismissed Edit Quantity VC!")
        }
    }
}

//extension EditQuantityViewController: SalesHistoryViewControllerDelegate {
//    func reloadData() {
//        <#code#>
//    }
//}
