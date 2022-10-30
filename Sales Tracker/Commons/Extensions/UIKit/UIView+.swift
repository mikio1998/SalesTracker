//
//  UIView+.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/28.
//

import UIKit

extension UIView {
    
    // roundCorners() needs to be called on .main thread, or after view's bounds has been initalized  (because we use frame radius).
    //https://stackoverflow.com/questions/35685726/uibezierpath-doesnt-work-in-topright-corner-and-bottomright-corner
    func roundCorners(for corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners,
                                cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func giveRoundCorners(withCornerRadius: CGFloat) {
        layer.cornerRadius = withCornerRadius
    }
    func giveShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 0.3
    }

    func giveSmallShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.3
    }
}


