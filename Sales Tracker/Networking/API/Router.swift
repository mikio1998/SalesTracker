//
//  Router.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/12/30.
//
import Foundation
import UIKit

protocol RouterProtocol {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var parameters: [URLQueryItem]? { get }
    var method: String { get }
}

// Sold Products are handled w/ Firestore
enum Router: RouterProtocol {
    case getProductsList(vendor: String)
    case getProduct(handle: String)
    case getProductFromBarcode(barcode: String)

    // Local Mode requires different scheme, host, and port components.
    private func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }

    var scheme: String {
        switch self {
        case .getProductsList, .getProduct, .getProductFromBarcode:
            let local = "http"
            let cloud = "https"
            return appDelegate().localMode ? local : cloud
        }
    }

    var host: String {
        switch self {
        case .getProductsList, .getProduct, .getProductFromBarcode:
            let local = "0.0.0.0"
            let cloud = "nakata-72f8a.appspot.com"
            return appDelegate().localMode ? local : cloud
        }
    }

    var port: Int? {
        appDelegate().localMode == false ? nil : 8000
    }

    var path: String {
        switch self {
        case .getProductsList(let vendor):
            return "/productslist" + "/\(String(describing: vendor))"
        case .getProduct(let handle):
            return "/product" + "/\(handle)"
        case .getProductFromBarcode(let barcode):
            return "/barcode" + "/\(barcode)"
        }
    }

    var parameters: [URLQueryItem]? {
//        let accessToken = ""
        switch self {
        case .getProductsList(_):
            return nil
        case .getProduct(_):
            return nil
        case .getProductFromBarcode(_):
            return nil
        }
    }

    var method: String {
        switch self {
        case .getProductsList, .getProduct, .getProductFromBarcode:
            return "GET"
        }
    }
}
