//
//  MockFirestoreManager.swift
//  Sales TrackerTests
//
//  Created by Mikio Nakata on 2022/12/16.
//

import Foundation
@testable import Sales_Tracker

class MockFirestoreManager: NetworkEngine {
    func getProductItems(forBrand brand: Brand, completion: @escaping (Result<[ProductItem], FirestoreError>) -> Void) {
        let items: [ProductItem] = [ProductItem.mock()]
        completion(.success(items))
    }
    func getSoldProductItems(completion: @escaping (Result<[SoldProductItem], FirestoreError>) -> Void) {
        let items: [SoldProductItem] = [SoldProductItem.mock()]
        completion(.success(items))
    }
    func queryFromProduct(barcode: String, completion: @escaping (Result<ProductItem?, FirestoreError>) -> ()) {
        let item: ProductItem = ProductItem.mock()
        completion(.success(item))
    }
    func soldAnItem(product: ProductItem, quantitySold: Int, completion: @escaping (Result<(), FirestoreError>) -> ()) {
        completion(.success(()))
    }
    func deleteSaleEntry(id: String, completion: @escaping (Result<(), FirestoreError>) -> ()) {
        completion(.success(()))
    }
    func updateSaleCountForItem(id: String, newCount: Int, completion: @escaping (Result<(), FirestoreError>) -> ()) {
        completion(.success(()))
    }
}
