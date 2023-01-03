//
//  ProductIndexModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/22.
//

import Foundation

protocol ProductIndexModel {
    func loadDataModel(vendor: Vendor, completion: @escaping (Result<ProductIndexDataModel, NetworkError>) -> Void)
}

final class ProductIndexModelImpl: ProductIndexModel {
    private let engine: NetworkEngine
    init(engine: NetworkEngine = FirestoreManager.shared) {
        self.engine = engine
    }

    func loadDataModel(vendor: Vendor, completion: @escaping (Result<ProductIndexDataModel, NetworkError>) -> Void) {
        ProductsListDataManager.loadVendorList(vendor: vendor) { result in
            switch result {
            case .failure(let err):
                completion(err)
            case .success(let prods):
                let dataModel = ProductIndexDataModel(brand: vendor, productItems: prods)
                completion(.success(dataModel))
            }
        }

//        engine.getProductItems(forBrand: brand) { result in
//            switch result {
//            case .failure(let fireErr):
//                completion(.failure(fireErr))
//            case .success(let productItems):
//                let dataModel = ProductIndexDataModel(brand: brand, productItems: productItems)
//                completion(.success(dataModel))
//            }
//        }
    }
}
