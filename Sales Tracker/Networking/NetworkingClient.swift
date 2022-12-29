//
//  NetworkingClient.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/12/29.
//

import Foundation
import Alamofire

class NetworkingClient {

    func execute(_ url: URL) {
        }
}

struct Prod: Decodable {
    let name: String
    let vendor: String
    let price: Float
    let variants: [ProdVariant]
}

struct ProdVariant: Decodable {
    let name: String
    let vendor: String
    let price: Float
    let size: String
    let color: String
    let url: String
}
