//
//  NetworkingClient.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/12/29.
//

import Foundation
import Alamofire

class NetworkingClient {
    func fetchData() {
        let request = AF.request("https://nakata-72f8a.appspot.com/products")
        request.responseDecodable(of: Prods.self) { response in
            guard let prods = response.value else {
                print("fail", response.error)
                return }
            print(prods)
        }
    }
}

struct Prods: Codable {
    let data: [String: Prod]
}

struct Prod: Codable {
    let name: String?
    let vendor: String?
    let price: String?
    let variants: [ProdVariant]
}

struct ProdVariant: Codable {
    let name: String?
    let vendor: String?
    let price: String?
    let size: String?
    let color: String?
    let url: String?
}
