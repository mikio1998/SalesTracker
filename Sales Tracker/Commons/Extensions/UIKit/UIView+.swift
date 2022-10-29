//
//  UIView+.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/28.
//

import UIKit

extension UIView {
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
