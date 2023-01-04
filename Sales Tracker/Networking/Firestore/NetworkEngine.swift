//
//  NetworkEngine.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/12/16.
//

import Foundation

// Get Product List, and Barcode are handled by Flask Restful.
protocol NetworkEngine {
    func getSoldProductItems(completion: @escaping (Result<[SoldProd], NetworkError>) -> Void)
    func soldAnItem(product: Prod, quantitySold: Int, completion: @escaping (Result<(), NetworkError>) -> Void) async
    func deleteSaleEntry(sku: String, completion: @escaping (Result<(), NetworkError>) -> Void)
    func updateSaleCountForItem(sku: String, newCount: Int, completion: @escaping (Result<(), NetworkError>) -> Void)
}
