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

    // Cache
    private var allData: Prods?
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
    static func loadList(reload: Bool = false, completion: @escaping (Result<Prods, Error>) -> Void) {
        if Self.shared.allData != nil && reload == false {
            guard let data = Self.shared.allData else {
                // If reload is false but no data, force a reload.
                loadList(reload: true, completion: completion)
                return
            }
            completion(.success(data))
        } else {
            ServiceLayer.request(router: Router.getProductsList(vendor: nil), completion: completion)
        }
    }

    static func loadVendorList(reload: Bool = false, vendor: Brand, completion: @escaping (Result<Prods, Error>) -> Void) {
        // Non-caching
        let dataSource: Prods? = {
            switch vendor {
            case .testBrand:
                return
            case .alphaIndustries:
                dataSource = ProductsListDataManager.shared.alphaData
            case .avirex:
                dataSource = ProductsListDataManager.shared.avirexData
            case .helikonTex:
                dataSource = ProductsListDataManager.shared.helikonTexData
            case .houston:
                dataSource = ProductsListDataManager.shared.houstonData
            case .sessler:
                dataSource = ProductsListDataManager.shared.sesslerData
            case .truSpec:
                dataSource = ProductsListDataManager.shared.truSpecData
            case .valleyApparel:
                dataSource = ProductsListDataManager.shared.valleyApparelData
            case .cockpit:
                dataSource = ProductsListDataManager.shared.cockpitData
            case .usSurplus:
                dataSource = ProductsListDataManager.shared.usSurplusData
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

//        Caching
//        guard let data = Self.shared.data else {
//            loadList { _ in
//                // If theres no data, call loadList.
//                loadVendorList(vendor: vendor, completion: completion)
//            }
//            return
//        }
//        // Sort brand from Prods (todo).

    }

}
