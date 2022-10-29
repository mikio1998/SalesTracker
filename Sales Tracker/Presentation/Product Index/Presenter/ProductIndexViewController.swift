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
    private let brandList: [Brand] = [Brand.TestBrand, Brand.AlphaIndustries]
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
        loadData(brand: self.brandList[0])
    }
    
    private func showLoadDataErrorAlert(error: FirestoreError) {
        // Left off here
        // Making error alert.
    }

    private func loadData(brand: Brand) {
        SVProgressHUD.show()
        model.loadDataModel(brand: brand) { result in
            SVProgressHUD.dismiss()
            switch result {
            case .failure(let fireErr):
                print("Show an alert.")
                self.viewContainer.noResults(error: fireErr)
            case .success(let dataModel):
                self.viewContainer.setTitle(dataModel.brand.officialBrandName)
                self.viewContainer.setSnapshot(dataModel.productIndexSnapshot)
                self.data = dataModel
            }
        }
    }
}

extension ProductIndexViewController: ProductIndexPresenterLike {
    func didTapListButton() {
        let chooseBrandVC = ChooseBrandViewController(list: brandList, productIndexDelegate: self)
        chooseBrandVC.modalPresentationStyle = .custom
        chooseBrandVC.transitioningDelegate = self
        self.present(chooseBrandVC, animated: true) {
            print("Presenting List.")
        }
    }
    
    func didSelectIndexPath(_ indexPath: IndexPath) {
        guard let prod = data?.productIndexSnapshot.itemIdentifiers(inSection: 0)[indexPath.row] else { return }
        let productSelectVC = ProductSelectViewController(productData: prod)
        productSelectVC.modalPresentationStyle = .custom
        productSelectVC.transitioningDelegate = self
        self.present(productSelectVC, animated: true) {
            print("Presenting Product.")
        }
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








// Notes

// typealias of a snapshot

// Init
//       viewContainer (ViewLike)
//       model
//       navigator
//   super.init nibname is nil, bundle is Self.self

// required Init

// loadView
//      view is viewContainers .view

// viewDidLoad
//      set viewContainers presenterLike to self.
//      UI stuff, like title or button
//      model networking, getting data.
//          create the data snapshot

// viewWillAppear
//      stuff to do everytime it shows
// viewWillDisappear


// Conform to PresenterLike
//      delegate methods
//      ie. the view's tableview taps a cell.

