//
//  Router.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/12/30.
//
import Foundation

enum Router {
    case getProductsList(_ vendor: String?)
    case getProduct(_ handle: String)
    case getSoldProducts
    case postSoldProduct(_ product: Prod)

    var scheme: String {
        switch self {
        case .getProductsList, .getProduct, .getSoldProducts, .postSoldProduct:
            return "https"
        }
    }

    var host: String {
        switch self {
        case .getProductsList, .getProduct, .getSoldProducts, .postSoldProduct:
            return "nakata-72f8a.appspot.com"
        }
    }

    var path: String {
        switch self {
        case .getProductsList:
            return "/productslist"
        case .getProduct(let handle):
            return "/product" + "/\(handle)"
        case .getSoldProducts:
            return "/soldproducts"
        case .postSoldProduct:
            return "/soldproducts"
        }
    }

    var parameters: [URLQueryItem] {
//        let accessToken = ""
        switch self {
        case .getProductsList(let vendor):
            return [URLQueryItem(name: "vendor", value: vendor)]
        case .getProduct(_):
            return []
        case .getSoldProducts:
            return []
        case .postSoldProduct(let product):
            return [URLQueryItem(name: "handle", value: vendor),
                    URLQueryItem(name: "name", value: vendor),
                    URLQueryItem(name: "vendor", value: vendor),
                    URLQueryItem(name: "color", value: vendor),
                    URLQueryItem(name: "size", value: vendor),
                    URLQueryItem(name: "price", value: vendor),
                    URLQueryItem(name: "url", value: vendor),
                    URLQueryItem(name: "quantity", value: vendor)
            ]
        }
    }

    var method: String {
        switch self {
        case .getProductsList, .getProduct, .getSoldProducts:
            return "GET"
        case .postSoldProduct(_):
            return "POST"
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
