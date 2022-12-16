//
//  MockModels.swift
//  Sales TrackerTests
//
//  Created by Mikio Nakata on 2022/12/16.
//

import Foundation

extension ProductItem {
    static func mock(id: String = "Test Id",
                     brand: String = "Test Brand",
                     name: String = "Test Name",
                     price: String = "1000",
                     color: String = "Black",
                     size: String = "S",
                     quantity: Int = 1,
                     imageUrl: String = "",
                     productNum: String = "AL-1",
                     barcodes: [String] = [] ) -> ProductItem
    {
        return ProductItem(id: id, brand: brand, name: name, price: price, color: color, size: size, imageUrl: imageUrl, productNum: productNum, barcodes: barcodes)
    }
}

extension SoldProductItem {
    static func mock(id: String = "Test Id",
                     brand: String = "Test Brand",
                     name: String = "Test Name",
                     price: String = "1000",
                     color: String = "Black",
                     size: String = "S",
                     quantity: Int = 1,
                     imageUrl: String = "",
                     productNum: String = "AL-1",
                     barcodes: [String] = [] ) -> SoldProductItem
    {
        return SoldProductItem(id: id, brand: brand, name: name, price: price, color: color, size: size, quantity: quantity, imageUrl: imageUrl, productNum: productNum, barcodes: barcodes)
    }
}
