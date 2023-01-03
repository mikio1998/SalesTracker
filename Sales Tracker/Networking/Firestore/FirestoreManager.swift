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

// MARK: ToDos:
//      Barcode query
//      Delete sale
//      Update sale count

class FirestoreManager: NetworkEngine {
    static let shared = FirestoreManager()

    private init() {}

    // Done
    // MARK: Get all products from Brand collection.
//    func getProductItems(forBrand brand: Brand, completion: @escaping (Result<[ProductItem], FirestoreError>) -> Void) {
//        let db = Firestore.firestore()
//        let query = db.collection("products").whereField("brand", isEqualTo: brand.collectionName)
//        query.getDocuments { _snapshot, err in
//            if err != nil {
//                completion(.failure(.getError))
//            } else {
//                if let snapshot = _snapshot {
//                    let products = snapshot.documents.compactMap {
//                        return try? $0.data(as: ProductItem.self)
//                    }
//                    completion(.success(products))
//                    return
//                } else {
//                    completion(.failure(.getError))
//                }
//            }
//            return
//        }
//    }

    // KEEP
    // MARK: Get Sales Collection
    // SoldProductItem
    func getSoldProductItems(completion: @escaping (Result<[Prod], FirestoreError>) -> Void) {
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

    // Barcode... not done
    // ProductItem
    func queryFromProduct(barcode: String, completion: @escaping (Result<Prod?, FirestoreError>) -> Void) {
        let db = Firestore.firestore()
        let query = db.collection("products").whereField("barcodes", arrayContains: barcode)
        query.getDocuments { _snapshot, err in
            if err != nil {
                completion(.failure(.getError))
            } else {
                if let snapshot = _snapshot {
                    let products = snapshot.documents.compactMap {
                        return try? $0.data(as: Prod.self)
                    }
                    if let first = products.first {
                        completion(.success(first))
                    } else {
                        completion(.success(nil))
                    }
                } else {
                    completion(.failure(.getError))
                }
            }
        }
    }


    // KEEP?
    // MARK: Search sales by id.
    // ProductItem
//    private static func queryForProductOrReturnNew(product: Prod) async throws -> Prod {
//        let db = Firestore.firestore()
//        guard let id = product.id else {
//            throw FirestoreError.getError }
//        let path = db.collection("sales track").document(id)
//        let prod: SoldProductItem = try await withCheckedThrowingContinuation({ continuation in
//            path.getDocument { _snapshot, err in
//                if err != nil {
//                    continuation.resume(throwing: FirestoreError.getError)
//                    return
//                } else {
//                    if let snapshot = _snapshot, snapshot.exists { // *Already in sales track.*
//                        do {
//                            let item = try snapshot.data(as: SoldProductItem.self)
//                            continuation.resume(returning: item)
//                        } catch {
//                            continuation.resume(throwing: FirestoreError.decodingError)
//                        }
//                    } else { // *New to sales track*
//                        let newItem = SoldProductItem(
//                            id: product.id,
//                            brand: product.brand,
//                            name: product.name,
//                            price: product.price,
//                            color: product.color,
//                            size: product.size,
//                            quantity: 0,
//                            imageUrl: product.imageUrl,
//                            productNum: product.productNum,
//                            barcodes: product.barcodes)
//                        continuation.resume(returning: newItem)
//                        return
//                    }
//                }
//            }
//        })
//        return prod
//    }

    // KEEP?
    // MARK: Setting a sale.
    private static func setSoldProductItem(product: SoldProductItem) throws {
        let db = Firestore.firestore()
        guard let id = product.id else { return }
        let path = db.collection("sales track").document(id)
        do {
            try path.setData(from: product)
        } catch let error {
            print(error)
        }
    }

    // KEEP?
    func soldAnItem(product: ProductItem, quantitySold: Int, completion: @escaping (Result<(), FirestoreError>) -> Void) async {
        do {
            var queryProduct = try await FirestoreManager.queryForProductOrReturnNew(product: product)
            queryProduct.quantity += quantitySold
            try FirestoreManager.setSoldProductItem(product: queryProduct)
            completion(.success(()))
        } catch _ {
            completion(.failure(.setError))
        }
    }

    // KEEP?
    // MARK: Delete Sale
    func deleteSaleEntry(id: String, completion: @escaping (Result<(), FirestoreError>) -> Void) {
        let db = Firestore.firestore()
        let path = db.collection("sales track").document(id)
        path.delete { err in
            if err != nil {
                completion(.failure(.deleteError))
            } else {
                completion(.success(()))
            }
        }
    }

    // KEEP?
    // MARK: Update sale item count
    func updateSaleCountForItem(id: String, newCount: Int, completion: @escaping (Result<(), FirestoreError>) -> Void) {
        let db = Firestore.firestore()
        let path = db.collection("sales track").document(id)
        path.updateData(["quantity": newCount]) { err in
            if err != nil {
                completion(.failure(.updateError))
            } else {
                completion(.success(()))
            }
        }
    }
}
