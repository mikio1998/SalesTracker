//
//  Router.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/12/30.
//
import Foundation

// Sold Products handled w/ Firestore
enum Router {
    case getProductsList(vendor: String?)
    case getProduct(handle: String)
    case getProductFromBarcode(barcode: String)

    var scheme: String {
        switch self {
        case .getProductsList, .getProduct, .getProductFromBarcode:
            return "https"
        }
    }

    var host: String {
        switch self {
        case .getProductsList, .getProduct, .getProductFromBarcode:
            return "nakata-72f8a.appspot.com"
        }
    }

    var path: String {
        switch self {
        case .getProductsList:
            return "/productslist"
        case .getProduct(let handle):
            return "/product" + "/\(handle)"
        case .getProductFromBarcode:
            return "/barcode"
        }
    }

    var parameters: [URLQueryItem] {
//        let accessToken = ""
        switch self {
        case .getProductsList(let vendor):
            return [URLQueryItem(name: "vendor", value: vendor)]
        case .getProduct(_):
            return []
        case .getProductFromBarcode(let barcode):
            return [URLQueryItem(name: "barcode", value: barcode)]
        }
    }

    var method: String {
        switch self {
        case .getProductsList, .getProduct, .getProductFromBarcode:
            return "GET"
        }
    }
}
