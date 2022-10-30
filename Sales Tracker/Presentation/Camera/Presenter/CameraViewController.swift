//
//  CameraViewController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/30.
//

import UIKit

protocol CameraViewPresenterLike: AnyObject {
    func didRecieveBarcodeData(_ stringValue: String)
}

final class CameraViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension CameraViewController: CameraViewPresenterLike {
    func didRecieveBarcodeData(_ stringValue: String) {
        // MARK: Firestore. query the product with barcode string.
    }
}
