//
//  SalesHistoryModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/27.
//

import Foundation

protocol SalesHistoryModel {
    func loadDataModel(completion: @escaping (Result<SalesHistoryDataModel, FirestoreError>) -> ())
}

final class SalesHistoryModelImpl: SalesHistoryModel {
    func loadDataModel(completion: @escaping (Result<SalesHistoryDataModel, FirestoreError>) -> ()) {
        FirestoreManager.getSoldProductItems { result in
            switch result {
            case .failure(let fireErr):
                completion(.failure(fireErr))
            case .success(let soldProductItems):
                let dataModel = SalesHistoryDataModel(soldProductItems: soldProductItems)
                completion(.success(dataModel))
            }
        }
    }
}
