//
//  ProductsListDataManager.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2023/01/03.
//

import Foundation

final class ProductsListDataManager {
    static let shared = ProductsListDataManager()

    private var data: Prods? // Cache

    private init() {}

    // Fetch cache, or perform request.
    static func loadList(reload: Bool = false, completion: @escaping (Result<Prods, Error>) -> Void) {
        if Self.shared.data != nil && reload == false {
            guard let data = Self.shared.data else {
                // If reload is false but no data, force a reload.
                loadList(reload: true, completion: completion)
                return
            }
            completion(.success(data))
        } else {
            ServiceLayer.request(router: Router.getProductsList(vendor: nil), completion: completion)
        }
    }
}
