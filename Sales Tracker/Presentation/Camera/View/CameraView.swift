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
}

final class CameraView: XibView {
    weak var presenterLike: CameraViewPresenterLike?
    private var videoLayer = AVCaptureVideoPreviewLayer()

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
        self.videoLayer = layer
        DispatchQueue.main.async {
            self.videoLayer.frame = self.layer.bounds
            self.layer.addSublayer(self.videoLayer)
        }
    }
}

extension CameraView: AVCaptureMetadataOutputObjectsDelegate {}
