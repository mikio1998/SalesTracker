//
//  FirestoreManager.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/19.
//
// Codable Firestore cheat sheet
// https://peterfriese.dev/posts/firestore-codable-the-comprehensive-guide/
// swiftlint:disable identifier_name

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import CloudKit

class FirestoreManager: NetworkEngine {
    static let shared = FirestoreManager()

    private init() {}

    // Should work?
    // MARK: Get Sales Collection
    // SoldProductItem
    func getSoldProductItems(completion: @escaping (Result<[Prod], NetworkError>) -> Void) {
        let db = Firestore.firestore()
        let path = db.collection("sales track")
        path.getDocuments { _snapshot, err in
            if err != nil {
                completion(.failure(.getError))
            } else {
                if let snapshot = _snapshot {
                    let products = snapshot.documents.compactMap {
                        return try? $0.data(as: Prod.self)
                    }
                    completion(.success(products))
                    return
                } else {
                    completion(.failure(.getError))
                }
            }
            completion(.failure(.getError))
            return
        }
    }

    // Barcode request handled by Flask Restful
    // ProductItem
//    func queryFromProduct(barcode: String, completion: @escaping (Result<Prod?, FirestoreError>) -> Void) {
//        let db = Firestore.firestore()
//        let query = db.collection("products").whereField("barcodes", arrayContains: barcode)
//        query.getDocuments { _snapshot, err in
//            if err != nil {
//                completion(.failure(.getError))
//            } else {
//                if let snapshot = _snapshot {
//                    let products = snapshot.documents.compactMap {
//                        return try? $0.data(as: Prod.self)
//                    }
//                    if let first = products.first {
//                        completion(.success(first))
//                    } else {
//                        completion(.success(nil))
//                    }
//                } else {
//                    completion(.failure(.getError))
//                }
//            }
//        }
//    }

    // MARK: Search sales by id (if already sold).
    // ProductItem
    private static func queryForProductOrReturnNew(product: Prod) async throws -> SoldProd {
        let db = Firestore.firestore()
        let sku = product.sku
        let path = db.collection("sales track").document(sku)
        let prod: SoldProd = try await withCheckedThrowingContinuation({ continuation in
            path.getDocument { _snapshot, err in
                if err != nil {
                    continuation.resume(throwing: NetworkError.getError)
                    return
                } else {
                    if let snapshot = _snapshot, snapshot.exists { // *Already in sales track.*
                        do {
                            let item = try snapshot.data(as: SoldProd.self)
                            continuation.resume(returning: item)
                        } catch {
                            continuation.resume(throwing: NetworkError.decodingError)
                        }
                    } else { // *New to sales track*
                        let newItem = SoldProd(prod: product, quantity: 0)
                        continuation.resume(returning: newItem)
                        return
                    }
                }
            }
        })
        return prod
    }

    // MARK: Setting a sale.
    private static func setSoldProductItem(product: SoldProd) throws {
        let db = Firestore.firestore()
        let sku = product.prod.sku
        let path = db.collection("sales track").document(sku)
        do {
            try path.setData(from: product) // MARK: Try as SoldProd, if not work change data struct.
        } catch let error {
            print(error)
        }
    }

    func soldAnItem(product: Prod, quantitySold: Int, completion: @escaping (Result<(), NetworkError>) -> Void) async {
        do {
            var queryProduct = try await FirestoreManager.queryForProductOrReturnNew(product: product)
            queryProduct.quantity += quantitySold
            try FirestoreManager.setSoldProductItem(product: queryProduct)
            completion(.success(()))
        } catch _ {
            completion(.failure(.setError))
        }
    }

    // MARK: Delete Sale
    func deleteSaleEntry(sku: String, completion: @escaping (Result<(), NetworkError>) -> Void) {
        let db = Firestore.firestore()
        let path = db.collection("sales track").document(sku)
        path.delete { err in
            if err != nil {
                completion(.failure(.deleteError))
            } else {
                completion(.success(()))
            }
        }
    }

    // MARK: Update sale item count
    func updateSaleCountForItem(sku: String, newCount: Int, completion: @escaping (Result<(), NetworkError>) -> Void) {
        let db = Firestore.firestore()
        let path = db.collection("sales track").document(sku)
        path.updateData(["quantity": newCount]) { err in
            if err != nil {
                completion(.failure(.updateError))
            } else {
                completion(.success(()))
            }
        }
    }
}
