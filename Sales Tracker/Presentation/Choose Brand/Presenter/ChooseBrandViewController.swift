//
//  ChooseBrandViewController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/27.
//

import UIKit

protocol ChooseBrandPresenterLike: AnyObject {
    func dismissPresenter(animated: Bool, reloadIndexFor brand: Brand?)
}

class ChooseBrandViewController: UIViewController {
    private let viewContainer: ChooseBrandViewLike
    private let productIndexDelegate: ProductIndexViewControllerDelegate
    
    init(list: [Brand], productIndexDelegate: ProductIndexViewControllerDelegate) {
        self.viewContainer = ChooseBrandView(list: list)
        self.productIndexDelegate = productIndexDelegate
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
extension ChooseBrandViewController: ChooseBrandPresenterLike {
    func dismissPresenter(animated: Bool, reloadIndexFor brand: Brand?) {
        self.dismiss(animated: true) {
            if let brand = brand {
                self.productIndexDelegate.reloadIndex(forBrand: brand)
            }
        }
    }
}
