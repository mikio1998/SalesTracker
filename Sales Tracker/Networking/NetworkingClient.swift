//
//  NetworkingClient.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/12/29.
//

import Foundation
import Alamofire

class ServiceLayer {
    class func request<T: Codable>(router: Router, completion: @escaping (Result<T, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.queryItems = router.parameters

        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let err = error {
                completion(.failure(err))
                print(err.localizedDescription)
                return
            }
            guard response != nil, let data = data else {
                return
            }

            var responseObject: T
            do {
                responseObject = try JSONDecoder().decode(T.self, from: data)
            } catch {
                return
            }

            DispatchQueue.main.async {
                completion(.success(responseObject))
            }
        }
        dataTask.resume()

    }
}

//ServiceLayer.request(router: Router.getProducts) { (result: Result<Prods, Error>) in
//    switch result {
//    case .success(let success):
//        print("suc", success)
//    case .failure(let err):
//        print("err", err)
//    }
//}



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
