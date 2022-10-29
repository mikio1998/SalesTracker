//
//  NSObject+Name.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/19.
//

import Foundation
extension NSObject {
    class var className: String {
        String(describing: self)
    }
    var className: String {
        String(describing: type(of: self))
    }
}
