//
//  ProductIndexDataModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/21.
//

import Foundation
import UIKit


typealias ProductIndexSnapshot = NSDiffableDataSourceSnapshot<Int, ProductIndexCollectionSnapshotDataModel>

struct ProductIndexDataModel {
    let brand: Brand
//    let productItemsData: [ProductItem]
    var productIndexSnapshot: ProductIndexSnapshot
    
    init(brand: Brand, productItems: [ProductItem]) {
        self.brand = brand
//        self.productItemsData = productItems // dont really need to keep anymore?
        self.productIndexSnapshot = ProductIndexSnapshot()
        self.productIndexSnapshot.appendSections([0])
        var variants = [String: [ProductItem]]()
        for item in productItems {
            guard let id = item.id else { continue }
            if variants.contains(where: { $0.key == item.name }) {
                variants[item.name]?.append(item)
            } else {
                variants[item.name] = [item]
            }
//            if variants.keys.contains(item.name) == false {
//                variants[item.name] = [item]
//            } else {
//                variants[item.name]?.append(item)
//            }
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

// TODO: Maybe make a [ProductItem] type to make this extension safer.
typealias ColorAndURL = (color: String, urlString: String)
extension Array where Element == ProductItem {
    private var colorAndImgArray: [ColorAndURL] {
        var uniques = [ColorAndURL]()
        for i in self {
            if !uniques.contains(where: { $0.color == i.color }) {
                uniques.append(ColorAndURL(color: i.color, urlString: i.imageUrl))
            }
        }
        return uniques
    }
    private var sizeArray: [String] {
        var uniques = [String]()
        for i in self {
            if !uniques.contains(i.size) {
                uniques.append(i.size)
            }
        }
        return uniques
    }
    func colorCount() -> Int {
        colorAndImgArray.count
    }
    func sizeCount() -> Int {
        return sizeArray.count
    }
    func getNthColorAndImg(n: Int) -> ColorAndURL {
        colorAndImgArray[n]
    }
    func getNthSize(n: Int) -> String {
        sizeArray[n]
    }
    func searchVariantDocumentIdFor(color:String, size: String) -> String? {
        self.first(where: { $0.color == color && $0.size == size })?.id
    }
}
