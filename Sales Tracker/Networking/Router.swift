//
//  Router.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/12/30.
//
import Foundation

enum Router {
    case getProductsList(_ vendor: String)
    case getProduct(_ handle: String)

    var scheme: String {
        switch self {
        case .getProductsList, .getProduct:
            return "https"
        }
    }

    var host: String {
        switch self {
        case .getProductsList, .getProduct:
            return "nakata-72f8a.appspot.com"
        }
    }

    var path: String {
        switch self {
        case .getProductsList:
            return "/productslist"
        case .getProduct(let handle):
            return "/product" + "/\(handle)"
        }
    }

    var parameters: [URLQueryItem] {
//        let accessToken = ""
        switch self {
        case .getProductsList(let vendor):
            return [URLQueryItem(name: "vendor", value: vendor)]
        case .getProduct(_):
            return []
        }
    }

    var method: String {
        switch self {
        case .getProductsList, .getProduct:
            return "GET"
        }
    }
}

//ServiceLayer.request(router: Router.getProduct("alpha-leatherjacket-cwu45p-black")) { (result: Result<Prod, Error>) in
//    switch result {
//    case .success(let success):
//        print("suc", success)
//    case .failure(let err):
//        print("err", err)
//    }
//}
