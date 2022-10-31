//
//  SalesHistoryDataModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/28.
//

import Foundation
import UIKit

typealias SalesHistorySnapshot = NSDiffableDataSourceSnapshot<Int, SalesHistoryTableSnapshotDataModel>

struct SalesHistoryDataModel {
    var itemCount: Int
    var salesHistorySnapshot: SalesHistorySnapshot
    init(soldProductItems: [SoldProductItem]) {
        self.itemCount = soldProductItems.reduce(0) { $0 + $1.quantity }
        self.salesHistorySnapshot = SalesHistorySnapshot()
        // TODO: Section, by Brand if you want.
//        var categories = [String: [SoldProductItem]]()
//        for item in soldProductItems {
//            if categories.contains(where: { $0.key == item.brand }) {
//                categories[item.brand]?.append(item)
//            } else {
//                categories[item.brand] = [item]
//            }
//        }
        self.salesHistorySnapshot.appendSections([0])
        var models = [SalesHistoryTableSnapshotDataModel]()
        for item in soldProductItems {
            let model = SalesHistoryTableSnapshotDataModel(
                soldProductItem: item)
            models.append(model)
        }
        self.salesHistorySnapshot.appendItems(models, toSection: 0)
    }
}

struct SalesHistoryTableSnapshotDataModel: Hashable {
    let soldProductItem: SoldProductItem
}
