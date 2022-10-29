//
//  UIImageView+URL.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/29.
//

import UIKit
import Nuke

extension UIImageView {
    func loadImage(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        loadImage(with: url)
    }

    func loadImage(with url: URL) {
        Nuke.loadImage(with: url, into: self)
    }
}
