//
//  ProductIndexDataModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/21.
//
// swiftlint:disable large_tuple

import Foundation
import UIKit

typealias ProductIndexSnapshot = NSDiffableDataSourceSnapshot<Int, ProductIndexCollectionSnapshotDataModel>

struct ProductIndexDataModel {
    let brand: Brand
    var productIndexSnapshot: ProductIndexSnapshot
    init(brand: Brand, productItems: [ProductItem]) {
        self.brand = brand
        self.productIndexSnapshot = ProductIndexSnapshot()
        self.productIndexSnapshot.appendSections([0])
        var variants = [String: [ProductItem]]()
        for item in productItems {
            guard item.id != nil else { continue }
            if variants.contains(where: { $0.key == item.name }) {
                variants[item.name]?.append(item)
            } else {
                variants[item.name] = [item]
            }
        }
        var models = [ProductIndexCollectionSnapshotDataModel]()
        for variant in variants {
            let model = ProductIndexCollectionSnapshotDataModel(
                brand: brand,
                name: variant.key,
                price: variant.value.first?.price ?? "",
                variants: variant.value)
            models.append(model)
        }
        self.productIndexSnapshot.appendItems(models, toSection: 0)
    }
}

struct ProductIndexCollectionSnapshotDataModel: Hashable {
    let brand: Brand
    let name: String
    let price: String
    let variants: [ProductItem]
}

typealias ColorURLProductNum = (color: String, urlString: String, productNum: String)
extension Array where Element == ProductItem {
    private var colorImgProductNumArray: [ColorURLProductNum] {
        var uniques = [ColorURLProductNum]()
        for i in self where !uniques.contains(where: { $0.color == i.color }) {
            uniques.append(ColorURLProductNum(color: i.color, urlString: i.imageUrl, productNum: i.productNum))
        }
        return uniques
    }
    private var sizeArray: [String] {
        var uniques = [String]()
        for i in self where !uniques.contains(i.size) {
            uniques.append(i.size)
        }
        let order: [String: Int] = [
            "XXS": 0,
            "XS": 1,
            "S": 2,
            "M": 3,
            "L": 4,
            "XL": 5,
            "XXL": 6,
            "XXXL": 7
        ]
        return uniques.sorted { a, b in
            return order[a] ?? order.keys.count < order[b] ?? order.keys.count
        }
    }
    func colorCount() -> Int {
        colorImgProductNumArray.count
    }
    func sizeCount() -> Int {
        return sizeArray.count
    }
    func getNthColorAndImg(n: Int) -> ColorURLProductNum {
        colorImgProductNumArray[n]
    }
    func getNthColor(n: Int) -> String {
        colorImgProductNumArray[n].color
    }
    func getNthImg(n: Int) -> String {
        colorImgProductNumArray[n].urlString
    }
    func getNthProductNum(n: Int) -> String {
        colorImgProductNumArray[n].productNum
    }
    func getNthSize(n: Int) -> String {
        sizeArray[n]
    }
    func searchVariantDocumentIdFor(color: String, size: String) -> String? {
        self.first(where: { $0.color == color && $0.size == size })?.id
    }
    func searchVariantBarcodesFor(color: String, size: String) -> [String] {
        self.first(where: { $0.color == color && $0.size == size })?.barcodes ?? []
    }
}
