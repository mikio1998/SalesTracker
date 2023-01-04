//
//  ServiceLayer.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/12/29.
//

import Foundation
//import Alamofire

class ServiceLayer {
    class func request<T: Codable>(router: Router, completion: @escaping (Result<T, NetworkError>) -> Void) {
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.host
        components.path = router.path
        components.port = router.port
//        components.queryItems = router.parameters

        guard let url = components.url else { return }
        print("url", url)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method

        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: urlRequest) { data, response, error in
            if let err = error {
                completion(.failure(NetworkError.general))
                print(err.localizedDescription)
                return
            }
            guard response != nil, let data = data else {
                completion(.failure(NetworkError.responseError))
                return
            }
            var responseObject: T
            do {
                responseObject = try JSONDecoder().decode(T.self, from: data)
            } catch {
                completion(.failure(NetworkError.decodingError))
                return
            }
            DispatchQueue.main.async {
                completion(.success(responseObject))
            }
        }
        dataTask.resume()
    }
}
