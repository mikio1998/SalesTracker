//
//  ProductItem.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/18.
//

import Foundation
import FirebaseFirestoreSwift

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
