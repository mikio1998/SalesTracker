//
//  ViewContainer.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/18.
//

import Foundation
import UIKit

protocol ViewContainer: AnyObject {
    var view: UIView { get }
}
extension ViewContainer where Self: UIView {
    var view: UIView { self }
}


// Notes

// This ViewContainer protocol is conformed by "ViewLike" protocols.
//      It gives each one the view: UIView property.
