//
//  MockFirestoreManager.swift
//  Sales TrackerTests
//
//  Created by Mikio Nakata on 2022/12/16.
//

import Foundation
@testable import Sales_Tracker

class MockFirestoreManager: NetworkEngine {
    func getProductItems(forBrand brand: Vendor, completion: @escaping (Result<[ProductItem], FirestoreError>) -> Void) {
        let items: [ProductItem] = [ProductItem.mock1()]
        completion(.success(items))
    }

    // MARK: - Sold Product Items
    var isGetSoldProductItemsCalled = false

    var soldProductItemsComplete: [SoldProductItem] = []

    var getSoldProductItemsComplete: ((Result<[SoldProductItem], FirestoreError>) -> Void)!
    func getSoldProductItemsSuccess() {
        getSoldProductItemsComplete(.success(soldProductItemsComplete))
    }
    func getSoldProductItemsFail(with error: NetworkError) {
        getSoldProductItemsComplete(.failure(error))
    }
    func getSoldProductItems(completion: @escaping (Result<[SoldProductItem], FirestoreError>) -> Void) {
        isGetSoldProductItemsCalled = true
        getSoldProductItemsComplete = completion
    }

    func deleteSaleEntry(id: String, completion: @escaping (Result<(), NetworkError>) -> Void) {
        completion(.success(()))
    }

    func queryFromProduct(barcode: String, completion: @escaping (Result<ProductItem?, FirestoreError>) -> Void) {
        let item: ProductItem = ProductItem.mock1()
        completion(.success(item))
    }
    func soldAnItem(product: ProductItem, quantitySold: Int, completion: @escaping (Result<(), NetworkError>) -> Void) {
        completion(.success(()))
    }

    func updateSaleCountForItem(id: String, newCount: Int, completion: @escaping (Result<(), NetworkError>) -> Void) {
        completion(.success(()))
    }
}
