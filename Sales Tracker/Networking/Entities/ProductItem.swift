//
//  ProductItem.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/18.
//

import Foundation
import FirebaseFirestoreSwift

// { data: {"SKU": [Prod]} }
struct Prods: Codable, Hashable {
    let data: [String: [Prod]]
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

struct Prod: Codable, Hashable {
    let name: String
    let vendor: String
    let price: String
    let size: String
    let color: String
    let url: String
    let sku: String
}

struct SoldProd: Codable {
    let prod: Prod
    var quantity: Int
}
