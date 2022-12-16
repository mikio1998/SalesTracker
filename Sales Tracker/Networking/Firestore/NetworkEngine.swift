//
//  NetworkEngine.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/12/16.
//

import Foundation

protocol NetworkEngine {
    func getProductItems(forBrand brand: Brand, completion: @escaping (Result<[ProductItem], FirestoreError>) -> Void)
    func getSoldProductItems(completion: @escaping (Result<[SoldProductItem], FirestoreError>) -> Void)
    func queryFromProduct(barcode: String, completion: @escaping (Result<ProductItem?, FirestoreError>) -> ())
    func soldAnItem(product: ProductItem, quantitySold: Int, completion: @escaping (Result<(), FirestoreError>) -> ()) async
    func deleteSaleEntry(id: String, completion: @escaping (Result<(), FirestoreError>) -> ())
    func updateSaleCountForItem(id: String, newCount: Int, completion: @escaping (Result<(), FirestoreError>) -> ())
}
