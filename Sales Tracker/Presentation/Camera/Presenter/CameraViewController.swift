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
//    private var videoLayer: AVCaptureVideoPreviewLayer
    private var model: CameraModel
    var videoLayer = AVCaptureVideoPreviewLayer()

//    init(viewContainer: CameraViewLike = CameraView()) {
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
    
//    override func viewWillAppear(_ animated: Bool) {
////        super.viewWillAppear(true)
//        configureVideoSession()
//    }
//    override func viewWillDisappear(_ animated: Bool) {
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewContainer.presenterLike = self
        model.startCam(delegate: self) { err in
            if let err = err {
                print("err", err)
                return
            } else {
                print("set up the cam")
                self.viewContainer.showVideo(layer: self.model.previewLayer)
            }
        }
    }
    
//    func configureVideoSession() {
//        // CALayer of video stream from device camera.
////        videoLayer = AVCaptureVideoPreviewLayer()
//
//        // Session input and output.
//        // - Session gets raw materials (data) from the input (the camera capture)
//        // - Session produces output depending on how we ask it to (qr code read, etc.).
//        let session = AVCaptureSession()
//
//        // MARK: Input
//        // Returns video as capture device, and make it the session input device.
//        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
//        do {
//            let input = try AVCaptureDeviceInput(device: captureDevice)
//            session.addInput(input)
//        } catch {
//            print("Failure to register capture device.")
//        }
//
//
//
//        // MARK: Output
//        let output = AVCaptureMetadataOutput()
//        session.addOutput(output)
//        // Process the output on the main thread (best performance).
//        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//        // Define type of output we want (qr code, ean13 barcode).
//        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.ean13]
//
////        output.metadataObjectTypes = output.availableMetadataObjectTypes
////        output.metadataObjectTypes = []
//
////        session.addOutput(output)
//
//        // CALayer of video stream from device camera.
//        videoLayer = AVCaptureVideoPreviewLayer(session: session)
//
//
//        // Set bounds, and add as Sublayer to View (delegate method).
//        viewContainer.showVideo(layer: videoLayer)
//
//        // Start the session.
//        session.startRunning()
//    }
    
    
    
}

extension CameraViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        print("output")
    }

}

extension CameraViewController: CameraViewPresenterLike {
    
}
