//
//  ViewController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/15.
//
//
//import UIKit
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        FirestoreManager.getProductsData(fromCollection: "products") { result in
//            switch result {
//            case .failure(let err):
//                print("ERROR:", err)
//            case .success(let products):
////                print("getProductsData:", products)
//                for product in products {
//                    print(product.name)
//                }
//            }
//        }
//
//
//        let prod = ProductItem(id: "AI-1111", brand: "Alpha", name: "Prod name", price: 1111, type: "Type Name", color: "Black", size: "S")
//
//
//        Task {
////            await testingAsync(product: prod)
//            await FirestoreManager.soldAnItem(product: prod, size: "S", color: "Black", quantitySold: 1, completion: { result in
//                switch result {
//                case .failure(let err):
//                    print("Error selling data:", err)
//                case .success():
//                    print("Successfully added sell.")
//                }
//            })
//            print("done...")
//
//
//        }
//
//        print("DONE!!!!")
//
//
////        FirestoreManager.setSaleData(product: product) { result in
////            switch result {
////            case .failure(let err):
////                print("ERROR:", err)
////            case .success():
////                print("Success setting Sale doc.")
////            }
////        }
//
//
//
//
//
//    }
//
////    func testingAsync(product: ProductItem) async {
////        do {
////            let findDoc = try await FirestoreManager.queryForProductWhere(name: product.name, size: product.size[0], color: product.color[0])
////            print("found sold item!!!", findDoc)
////
////
////        } catch let error {
////            if error as! FirestoreError == FirestoreError.noSuchDocumentError {
////                print("It was no such doc")
////            } else {
////                print("oops")
////            }
////        }
////    }
//
//}
//
