//
//  CameraView.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/30.
//

import Foundation
import AVFoundation

protocol CameraViewLike: ViewContainer {
//    var presenterLike: CameraViewPresenterLike? { get set }
}

final class CameraView: XibView {
//    weak var presenterLike: CameraViewPresenterLike?
    // Outlets
    
    init() {
        super.init(frame: .zero)
    }
    @available(*, unavailable)
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension CameraView: CameraViewLike {}


