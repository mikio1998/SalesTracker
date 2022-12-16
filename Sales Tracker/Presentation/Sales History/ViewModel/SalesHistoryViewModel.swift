//
//  SalesHistoryViewModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/12/15.
//

import Foundation
import UIKit

class SalesHistoryViewModel {
    var reloadTableView: (() -> Void)?
    
    var updateTitleCount: ((_ count: Int) -> Void)?
    
    var presentAlert: ((_ title: String, _ msg: String) -> Void)?
    
    var showNoResults: ((FirestoreError?) -> Void)?
    
    var presentEditQuantityVC: ((_ product: SoldProductItem) -> Void)?
    
    var soldProductItems = [SoldProductItem]() {
        didSet {
            let count = soldProductItems.reduce(0) { partialResult, item in
                return partialResult + item.quantity
            }
            updateTitleCount?(count)
        }
    }
    
    var salesHistoryCellViewModels = [SalesHistoryCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init() {}
    
    func getSalesHistory() {
        FirestoreManager.getSoldProductItems { [weak self] result in
            switch result {
            case .failure(let fireErr):
                self?.presentAlert?("エラー発生", fireErr.message)
                self?.showNoResults?(fireErr)
            case .success(let soldProductItems):
                self?.fetchData(soldProductItems: soldProductItems)
            }
        }
    }
    
    func fetchData(soldProductItems: [SoldProductItem]) {
        self.soldProductItems = soldProductItems // cache
        var vms = [SalesHistoryCellViewModel]() //create VMs of cells.
        for item in soldProductItems {
            vms.append(SalesHistoryCellViewModel(soldProductItem: item))
        }
        self.salesHistoryCellViewModels = vms
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> SalesHistoryCellViewModel {
        return salesHistoryCellViewModels[indexPath.row]
    }
    
    
    func didSelectDeleteFor(_ indexPath: IndexPath) {
        guard let productId = salesHistoryCellViewModels[indexPath.row].soldProductItem.id else { return }
        FirestoreManager.deleteSaleEntry(id: productId) { [weak self] result in
            switch result {
            case .failure(let fireErr):
                self?.presentAlert?("失敗", fireErr.message)
            case .success():
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
