//
//  CameraView.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/30.
//

import Foundation
import AVFoundation

protocol CameraViewLike: ViewContainer {
    var presenterLike: CameraViewPresenterLike? { get set }
    func showVideo(layer: AVCaptureVideoPreviewLayer)
    func showVid()
}

final class CameraView: XibView {
    weak var presenterLike: CameraViewPresenterLike?
    var videoLayer = AVCaptureVideoPreviewLayer()
    // Outlets
    
    init() {
        super.init(frame: .zero)

    }
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension CameraView: CameraViewLike {
    func showVideo(layer: AVCaptureVideoPreviewLayer) {
        print("show")
        
        self.videoLayer = layer
        DispatchQueue.main.async {
            self.videoLayer.frame = self.layer.bounds
            self.layer.addSublayer(self.videoLayer)
        }
        
        
    }
    
    func showVid() {
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
//        // MARK: Output
//        let output = AVCaptureMetadataOutput()
//        // Process the output on the main thread (best performance).
//        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
//        // Define type of output we want (qr code, ean13 barcode).
////        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.ean13]
//        session.addOutput(output)
//
//        // CALayer of video stream from device camera.
//        videoLayer = AVCaptureVideoPreviewLayer(session: session)
//
//        DispatchQueue.main.async {
//            self.videoLayer.frame = self.layer.bounds
//            self.layer.addSublayer(self.videoLayer)
//        }
//
//        // Start the session.
//        session.startRunning()
    }
    
    
    
}
extension CameraView: AVCaptureMetadataOutputObjectsDelegate {}

