//
//  FirestoreError.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/30.
//

import Foundation

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
