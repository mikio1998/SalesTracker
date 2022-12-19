//
//  ProductIndexViewController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/18.
//

import UIKit
import SVProgressHUD

protocol ProductIndexPresenterLike: AnyObject {
    func didTapListButton()
    func didSelectIndexPath(_ indexPath: IndexPath)
}

protocol ProductIndexViewControllerDelegate: AnyObject {
    func reloadIndex(forBrand brand: Brand)
}

class ProductIndexViewController: UIViewController {
    private let viewContainer: ProductIndexViewLike
    private let model: ProductIndexModel
    private var data: ProductIndexDataModel?
    private let navigator: ProductIndexNavigatorLike
    
    init(viewContainer: ProductIndexViewLike = ProductIndexView(),
         model: ProductIndexModel = ProductIndexModelImpl(),
         navigator: ProductIndexNavigatorLike = ProductIndexNavigator()
    ) {
        self.viewContainer = viewContainer
        self.model = model
        self.navigator = navigator

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
        loadData(brand: Const.brandList[0])
    }

    private func loadData(brand: Brand) {
        SVProgressHUD.show()
        model.loadDataModel(brand: brand) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .failure(let fireErr):
                UIAlertController(title: "エラー発生", message: fireErr.message, preferredStyle: .alert)
                    .addOK()
                    .show(fromVC: self)
                self.viewContainer.noResults(error: fireErr)
            case .success(let dataModel):
                self.viewContainer.setTitleAndImage(dataModel.brand.officialBrandName, imageUrl: dataModel.brand.brandLogoUrl)
                self.viewContainer.setSnapshot(dataModel.productIndexSnapshot)
                self.data = dataModel
            }
        }
    }
}

extension ProductIndexViewController: ProductIndexPresenterLike {
    func didTapListButton() {
        let chooseBrandVC = ChooseBrandViewController(list: Const.brandList, productIndexDelegate: self)
        chooseBrandVC.modalPresentationStyle = .custom
        chooseBrandVC.transitioningDelegate = self
        self.present(chooseBrandVC, animated: true, completion: nil)
    }
    
    func didSelectIndexPath(_ indexPath: IndexPath) {
        guard let prod = data?.productIndexSnapshot.itemIdentifiers(inSection: 0)[indexPath.row] else { return }
        let productSelectVC = ProductSelectViewController(productData: prod)
        productSelectVC.modalPresentationStyle = .custom
        productSelectVC.transitioningDelegate = self
        self.present(productSelectVC, animated: true, completion: nil)
    }
}

extension ProductIndexViewController: ProductIndexViewControllerDelegate {
    func reloadIndex(forBrand brand: Brand) {
        self.loadData(brand: brand)
    }
}

extension ProductIndexViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension ProductIndexViewController {
    private enum Const {
        static let brandList: [Brand] = [Brand.alphaIndustries, Brand.avirex, Brand.helikonTex, Brand.houston, Brand.sessler, Brand.truSpec, Brand.valleyApparel, Brand.cockpit, Brand.usSurplus]
    }
}
