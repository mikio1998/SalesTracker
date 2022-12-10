//
//  CameraViewController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/30.
//

import UIKit
import AVFoundation

protocol CameraViewPresenterLike: AnyObject {
}

final class CameraViewController: UIViewController {
    
    private let viewContainer: CameraViewLike
    private var model: CameraModel

    init(viewContainer: CameraViewLike = CameraView(), model: CameraModel = CameraModelImpl()) {
        self.viewContainer = viewContainer
        self.model = model
        super.init(nibName: nil, bundle: Bundle(for: Self.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = viewContainer.view
    }
    
    override func viewWillAppear(_ animated: Bool) {
        model.startSession()
    }
    override func viewWillDisappear(_ animated: Bool) {
        model.stopSession()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContainer.presenterLike = self
        model.startCam(delegate: self) { err in
            if let err = err {
                print("err", err)
                // MARK: TODO, camera err alert.
                return
            } else {
                self.viewContainer.showVideo(layer: self.model.previewLayer)
            }
        }
    }
}

extension CameraViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        
        // MARK: just pass AVCaptureMetadataOutput to model method, later.
        model.queryWithObjects(metadataObjects) { result in
            switch result {
            case .failure(let fireErr):
                print("err", fireErr)
                // todo, show error on presenter.
                
            case .success(let productItem):
                let model = ProductIndexCollectionSnapshotDataModel(brand: Brand(name: productItem!.brand), name: productItem!.name, price: productItem!.price, variants: [productItem!])

                let productSelectVC = ProductSelectViewController(productData: model)

                productSelectVC.modalPresentationStyle = .custom
                productSelectVC.transitioningDelegate = self
                self.present(productSelectVC, animated: true, completion: nil)
            }
        }
        
        
    }
}

extension CameraViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }
}

extension CameraViewController: CameraViewPresenterLike {
}
