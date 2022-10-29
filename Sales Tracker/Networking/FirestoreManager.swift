//
//  FirestoreManager.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/19.
//
// Codable Firestore cheat sheet
// https://peterfriese.dev/posts/firestore-codable-the-comprehensive-guide/

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift
import CloudKit

enum FirestoreError: Error {
    case getError
    case setError
    case updateError
    case deleteError
    case decodingError
    
    var message: String {
        switch self {
        case .getError:
            return "Error getting documents."
        case .setError:
            return "Error getting documents."
        case .updateError:
            return "Error updating documents."
        case .deleteError:
            return "Error deleting document."
        case .decodingError:
            return "Error decoding document data."
        }
    }
}


final class FirestoreManager {
    static let shared = FirestoreManager()
    
    private init() {}
    
    
    // MARK: Get all products from Brand collection.
    static func getProductItems(forBrand brand: Brand, completion: @escaping (Result<[ProductItem], FirestoreError>) -> Void) {
        let db = Firestore.firestore()
        let path = db.collection(brand.collectionName)
        path.getDocuments { _snapshot, err in
            if err != nil {
                completion(.failure(.getError))
            } else {
                if let snapshot = _snapshot {
                    let products = snapshot.documents.compactMap {
                        return try? $0.data(as: ProductItem.self)
                    }
                    
                    completion(.success(products))
                    return
                } else {
                    completion(.failure(.getError))
                }
            }
            return
        }
    }
    
    // MARK: Get Sales Collection
    static func getSoldProductItems(completion: @escaping (Result<[SoldProductItem], FirestoreError>) -> Void) {
        let db = Firestore.firestore()
        let path = db.collection("sales track")
        path.getDocuments { _snapshot, err in
            if err != nil {
                completion(.failure(.getError))
            } else {
                if let snapshot = _snapshot {
                    let products = snapshot.documents.compactMap {
                        return try? $0.data(as: SoldProductItem.self)
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


    // MARK: Search sales by name, size, color.
    private static func queryForProductOrReturnNew(product: ProductItem) async throws -> SoldProductItem {
        let db = Firestore.firestore()
        guard let id = product.id else {
            throw FirestoreError.getError }
        let path = db.collection("sales track").document(id)
        let prod: SoldProductItem = try await withCheckedThrowingContinuation({ continuation in
            path.getDocument { _snapshot, err in
                if err != nil {
                    continuation.resume(throwing: FirestoreError.getError)
                    return
                } else {
                    if let snapshot = _snapshot, snapshot.exists {
                        print("Not new item.")
                        do {
                            let item = try snapshot.data(as: SoldProductItem.self)
                            continuation.resume(returning: item)
                        } catch {
                            continuation.resume(throwing: FirestoreError.decodingError)
                        }
                    } else {
                        print("New item.")
                        let newItem = SoldProductItem(id: product.id, brand: product.brand, name: product.name, price: product.price, color: product.color, size: product.size, quantity: 0, imageUrl: product.imageUrl)
                        continuation.resume(returning: newItem)
                        return
                    }
                }
            }
        })
        return prod
    }
    
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
    
    static func soldAnItem(product: ProductItem, size: String, color: String, quantitySold: Int, completion: @escaping (Result<(), FirestoreError>) -> ()) async {
        do {
            var queryProduct = try await queryForProductOrReturnNew(product: product)
            queryProduct.quantity += quantitySold
            
            try setSoldProductItem(product: queryProduct)
            completion(.success(()))
        } catch let error {
            print("Error soldAnItem:", error)
            completion(.failure(.setError))
        }
    }
    
    // MARK: Delete Sale
    static func deleteSaleEntry(id: String, completion: @escaping (Result<(), FirestoreError>) -> ()) {
        let db = Firestore.firestore()
        let path = db.collection("sales track").document(id)
        path.delete() { err in
            if err != nil {
                completion(.failure(.deleteError))
            } else {
                completion(.success(()))
            }
        }
    }

    // MARK: Update sale item count
    static func updateSaleCountForItem(id: String, newCount: Int, completion: @escaping (Result<(), FirestoreError>) -> ()) {
        let db = Firestore.firestore()
        let path = db.collection("sales track").document(id)
        path.updateData(["quantity" : newCount]) { err in
            if err != nil {
                completion(.failure(.updateError))
            } else {
                print("Wrote new count to ", id)
                completion(.success(()))
            }
        }
    }
}
