//
//  ProductIndexModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/22.
//

import Foundation

protocol ProductIndexModel {
    func loadDataModel(brand: Brand, completion: @escaping (Result<ProductIndexDataModel, FirestoreError>) -> ())
}

final class ProductIndexModelImpl: ProductIndexModel {
    func loadDataModel(brand: Brand, completion: @escaping (Result<ProductIndexDataModel, FirestoreError>) -> ()) {
        FirestoreManager.getProductItems(forBrand: brand) { result in
            switch result {
            case .failure(let fireErr):
                completion(.failure(fireErr))
            case .success(let productItems):
                let dataModel = ProductIndexDataModel(brand: brand, productItems: productItems)
                completion(.success(dataModel))
            }
        }
    }
}
