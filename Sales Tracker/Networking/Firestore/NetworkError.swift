//
//  NetworkError.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/30.
//

import Foundation

enum NetworkError: Error {
    case getError
    case setError
    case updateError
    case deleteError
    case decodingError
    case responseError
    case general

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
            return "Error decoding data."
        case .responseError:
            return "Error obtaining api response."
        case .general:
            return "Networking error has occured."
        }
    }
}
