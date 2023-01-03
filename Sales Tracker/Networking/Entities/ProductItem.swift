//
//  ProductItem.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/18.
//

import Foundation
import FirebaseFirestoreSwift

//struct Prod: Codable {
//    let name: String
//    let vendor: String
//    let price: String
//    let variants: [ProdVariant]
//    enum CodingKeys: String, CodingKey {
//        case name
//        case vendor
//        case price
//        case variants
//    }
//}


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

//protocol Product {
//    var brand: String { get set }
//    var name: String { get set }
//    var price: String { get set }
//    var color: String { get set }
//    var size: String { get set }
//    var imageUrl: String { get set }
//    var productNum: String { get set }
//    var barcodes: [String] { get set }
//}
//
//struct ProductItem: Codable, Hashable, Product {
//    @DocumentID var id: String?
//    var brand: String
//    var name: String
//    var price: String
//    var color: String
//    var size: String
//    var imageUrl: String
//    var productNum: String
//    var barcodes: [String]
//}
//
//struct SoldProductItem: Codable, Hashable, Product {
//    @DocumentID var id: String?
//    var brand: String
//    var name: String
//    var price: String
//    var color: String
//    var size: String
//    var quantity: Int
//    var imageUrl: String
//    var productNum: String
//    var barcodes: [String]
//}
//
//struct SalesTrack: Codable {
//    @DocumentID var id: String?
//    var brand: String
//    var color: String
//    var name: String
//    var price: Int
//    var size: String
//    var type: String
//    var quantity: Int
//
//    init(brand: String,
//         color: String,
//         name: String,
//         price: Int,
//         size: String,
//         type: String,
//         quantity: Int) {
//        self.id = color + size
//        self.brand = brand
//        self.color = color
//        self.name = name
//        self.price = price
//        self.size = size
//        self.type = type
//        self.quantity = quantity
//    }
//}
