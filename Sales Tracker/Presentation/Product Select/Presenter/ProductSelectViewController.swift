//
//  ProductSelectViewController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/25.
//

import UIKit
import SVProgressHUD

protocol ProductSelectPresenterLike: AnyObject {
    func dismissPresenter(animated: Bool)
    func didTapAddButton(item: ProductItem, quantity: Int)
}

final class ProductSelectViewController: UIViewController {
    
    private let viewContainer: ProductSelectViewLike
//    private let model: ProductSelectModel
    private let dataModel: ProductIndexCollectionSnapshotDataModel
//    private let navigator: ProductIndexNavigatorLike
    
    init(productData: ProductIndexCollectionSnapshotDataModel) {
        self.viewContainer = ProductSelectView(data: productData)
        self.dataModel = productData
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
extension ProductSelectViewController: ProductSelectPresenterLike {
    
    func didTapAddButton(item: ProductItem, quantity: Int) {
        SVProgressHUD.show()
        Task {
            await FirestoreManager.soldAnItem(product: item, quantitySold: quantity, completion: { result in
                SVProgressHUD.dismiss()
                switch result {
                case .failure(let fireErr):
                    DispatchQueue.main.async {
                        UIAlertController(title: "エラー発生", message: fireErr.message, preferredStyle: .alert)
                            .addOK()
                            .show(fromVC: self)
                    }
                case .success(()):
                    DispatchQueue.main.async {
                        UIAlertController(title: "追加!", message: nil, preferredStyle: .alert)
                            .showAndDismiss(fromVC: self, deadline: .now() + 0.7) {
                                self.dismissPresenter(animated: true)
                            }
                    }
                }
            })
        }
    }
    
    func dismissPresenter(animated: Bool) {
        self.dismiss(animated: true) {
            print("Dismissed Product Select VC!")
        }
    }
}
