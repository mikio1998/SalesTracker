//
//  EditQuantityViewController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/28.
//

import UIKit

protocol EditQuantityPresenterLike: AnyObject {
    func dismissPresenter(animated: Bool)
}

final class EditQuantityViewController: UIViewController {
    private let viewContainer: EditQuantityViewLike
    
    init(soldItem: SoldProductItem) {
        self.viewContainer = EditQuantityView(soldItem: soldItem)
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
            print("Dismissed Edit Quantity VC!")
        }
    }
}
