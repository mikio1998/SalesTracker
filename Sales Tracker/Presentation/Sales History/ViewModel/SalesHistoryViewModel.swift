//
//  SalesHistoryViewModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/12/15.
//

import Foundation

class SalesHistoryViewModel {
    var reloadTableView: (() -> Void)?

    var updateTitle: ((_ string: String) -> Void)?

    var presentAlert: (() -> Void)?

    var showNoResults: ((NetworkError?) -> Void)?

    var presentEditQuantityVC: ((_ product: SoldProd) -> Void)?

    var toggleSVProgressHUD: (() -> Void)?

    var soldProductItems = [SoldProd]() {
        didSet {
            let count = soldProductItems.reduce(0) { partialResult, item in
                return partialResult + item.quantity
            }
            titleItemCount = count
        }
    }

    var titleItemCount: Int? {
        didSet {
            self.updateTitle?("在庫補充 (\(titleItemCount!)点)")
        }
    }

    var salesHistoryCellViewModels = [SalesHistoryCellViewModel]() {
        didSet {
            if salesHistoryCellViewModels.isEmpty {
                self.reloadTableView?()
            } else {
                self.showNoResults?(nil)
            }
            self.isLoading = false
        }
    }

    var alert: (title: String, msg: String)? {
        didSet {
            self.presentAlert?()
        }
    }

    var isLoading: Bool = false {
        didSet {
            self.toggleSVProgressHUD?()
        }
    }

    private let engine: NetworkEngine

    init(engine: NetworkEngine = FirestoreManager.shared) {
        self.engine = engine
    }

    func getSalesHistory() {
        self.isLoading = true
        engine.getSoldProductItems { [weak self] result in
            switch result {
            case .failure(let fireErr):
                self?.alert = ("エラー発生", fireErr.message)
                self?.showNoResults?(fireErr)
            case .success(let soldProductItems):
                self?.processFetchedItems(soldProductItems: soldProductItems)
            }
        }
    }

    func processFetchedItems(soldProductItems: [SoldProd]) {
        self.soldProductItems = soldProductItems // cache
        var vms = [SalesHistoryCellViewModel]() // create VMs of cells.
        for item in soldProductItems {
            vms.append(SalesHistoryCellViewModel(soldProductItem: item))
        }
        self.salesHistoryCellViewModels = vms
    }

    func getCellViewModel(at indexPath: IndexPath) -> SalesHistoryCellViewModel {
        return salesHistoryCellViewModels[indexPath.row]
    }

    func didSelectDeleteFor(_ indexPath: IndexPath) {
        guard indexPath.row < salesHistoryCellViewModels.count else { return }
        let productSKU = salesHistoryCellViewModels[indexPath.row].soldProductItem.prod.sku

        engine.deleteSaleEntry(sku: productSKU) { [weak self] result in
            switch result {
            case .failure(let fireErr):
                self?.alert = ("失敗", fireErr.message)
            case .success:
                self?.getSalesHistory()
            }
        }
    }

    func didSelectEditFor(_ indexPath: IndexPath) {
        guard salesHistoryCellViewModels.indices.contains(indexPath.row) else { return }
        let product = salesHistoryCellViewModels[indexPath.row].soldProductItem
        self.presentEditQuantityVC?(product)
    }
}
