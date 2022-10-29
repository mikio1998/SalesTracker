//
//  ProductSelectViewController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/25.
//

import UIKit

protocol ProductSelectPresenterLike: AnyObject {
    func dismissPresenter(animated: Bool)
}

final class ProductSelectViewController: UIViewController {
    
    private let viewContainer: ProductSelectViewLike
//    private let model: ProductSelectModel
//    private let navigator: ProductIndexNavigatorLike
    
    init(productData: ProductIndexCollectionSnapshotDataModel) {
        self.viewContainer = ProductSelectView(data: productData)
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
    func dismissPresenter(animated: Bool) {
        self.dismiss(animated: true) {
            print("Dismissed Product Select VC!")
        }
    }
    
    
}
