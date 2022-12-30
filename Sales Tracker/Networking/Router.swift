//
//  Router.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/12/30.
//
import Foundation

enum Router {
    case getProducts

    var scheme: String {
        switch self {
        case .getProducts:
            return "https"
        }
    }

    var host: String {
        switch self {
        case .getProducts:
            return "nakata-72f8a.appspot.com"
        }
    }

    var path: String {
        switch self {
        case .getProducts:
            return "/products"
        }
    }

    var parameters: [URLQueryItem] {
        let accessToken = ""
        switch self {
        case .getProducts:
            return [URLQueryItem(name: "", value: ""),
                    URLQueryItem(name: "access_token", value: accessToken)]
        }
    }

    var method: String {
        switch self {
        case .getProducts:
            return "GET"
        }
    }
}
