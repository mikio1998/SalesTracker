//
//  ProductsListDataManager.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2023/01/03.
//

import Foundation

// Caching data to save GCloud cost.
final class ProductsListDataManager {
    static let shared = ProductsListDataManager()

    // Caches
//    private var allData: Prods?
    private var alphaData: Prods?
    private var avirexData: Prods?
    private var helikonTexData: Prods?
    private var houstonData: Prods?
    private var sesslerData: Prods?
    private var truSpecData: Prods?
    private var valleyApparelData: Prods?
    private var cockpitData: Prods?
    private var usSurplusData: Prods?

    private init() {}

    // Fetch cache, or perform request.
//    static func loadList(reload: Bool = false, completion: @escaping (Result<Prods, NetworkError>) -> Void) {
//        if Self.shared.allData != nil && reload == false {
//            guard let data = Self.shared.allData else {
//                // If reload is false but no data, force a reload.
//                loadList(reload: true, completion: completion)
//                return
//            }
//            completion(.success(data))
//        } else {
//            ServiceLayer.request(router: Router.getProductsList(vendor: nil), completion: completion)
//        }
//    }

    static func loadVendorList(reload: Bool = false, vendor: Vendor, completion: @escaping (Result<Prods, NetworkError>) -> Void) {
        let dataSource: Prods? = {
            switch vendor {
            case .testBrand:
                return ProductsListDataManager.shared.helikonTexData
            case .alphaIndustries:
                return ProductsListDataManager.shared.alphaData
            case .avirex:
                return ProductsListDataManager.shared.avirexData
            case .helikonTex:
                return ProductsListDataManager.shared.helikonTexData
            case .houston:
                return ProductsListDataManager.shared.houstonData
            case .sessler:
                return ProductsListDataManager.shared.sesslerData
            case .truSpec:
                return ProductsListDataManager.shared.truSpecData
            case .valleyApparel:
                return ProductsListDataManager.shared.valleyApparelData
            case .cockpit:
                return ProductsListDataManager.shared.cockpitData
            case .usSurplus:
                return ProductsListDataManager.shared.usSurplusData
            }
        }()

        if dataSource != nil && reload == false {
            guard let data = dataSource else {
                // If reload is false but no data, force a reload.
                loadVendorList(reload: true, vendor: vendor, completion: completion)
                return
            }
            completion(.success(data))
        } else {
            ServiceLayer.request(router: Router.getProductsList(vendor: vendor.vendorName), completion: completion)
        }
    }

}
