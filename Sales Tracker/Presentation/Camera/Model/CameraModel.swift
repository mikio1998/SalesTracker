//
//  CameraModel.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/11/05.
//

import Foundation
import AVFoundation

protocol CameraModel {
    var previewLayer: AVCaptureVideoPreviewLayer { get }
    func startCam(delegate: AVCaptureMetadataOutputObjectsDelegate, completion: @escaping (Error?) -> ())
}

final class CameraModelImpl: CameraModel {
    weak var captureDelegate: AVCaptureMetadataOutputObjectsDelegate?
    var session: AVCaptureSession?
    let output = AVCaptureMetadataOutput()
    let previewLayer = AVCaptureVideoPreviewLayer()
    
    func startCam(delegate: AVCaptureMetadataOutputObjectsDelegate, completion: @escaping (Error?) -> ()) {
        self.captureDelegate = delegate
        output.setMetadataObjectsDelegate(delegate, queue: DispatchQueue.main)
        checkVideoPermissions(completion: completion)
    }
    private func checkVideoPermissions(completion: @escaping (Error?) -> ()) {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                self.setUpCamera(completion: completion)
            }
        case .restricted:
            break
        case .denied:
            break
        case .authorized:
            setUpCamera(completion: completion)
        @unknown default:
            break
        }
    }
    
    private func setUpCamera(completion: @escaping (Error?) -> ()) {
        let session = AVCaptureSession()
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            if session.canAddInput(input) {
                session.addInput(input)
            }
            
            if session.canAddOutput(output) {
                session.addOutput(output)
                output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr, AVMetadataObject.ObjectType.ean13]
            }
            previewLayer.session = session
            session.startRunning()
            self.session = session
            completion(nil)
        } catch {
            completion(error)
        }
    }
    
    private func stopSession() {
        guard let session = session, session.isRunning == true else { return }
        session.stopRunning()
    }
    
    
    
}
