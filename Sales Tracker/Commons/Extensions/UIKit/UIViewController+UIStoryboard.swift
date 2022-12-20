//
//  UIViewController+UIStoryboard.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/19.
//
// swiftlint:disable force_cast

import Foundation
import UIKit

extension UIViewController: StoryboardLoadable { }

protocol StoryboardLoadable { }

extension StoryboardLoadable where Self: UIViewController {
    static func loadStoryboard() -> Self {
        let storyboard = UIStoryboard(name: self.className, bundle: Bundle(for: self))
        return storyboard.instantiateViewController(withIdentifier: self.className) as! Self
    }

    // When you load to a specified storyboard.
    static func loadStoryboard(storyboardName: String) -> Self {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle(for: self))
        return storyboard.instantiateViewController(withIdentifier: self.className) as! Self
    }
}
