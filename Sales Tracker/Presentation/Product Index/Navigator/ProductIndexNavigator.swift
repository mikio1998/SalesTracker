//
//  ProductIndexNavigator.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/19.
//

import Foundation
import UIKit

protocol ProductIndexNavigatorLike {}

final class ProductIndexNavigator: ProductIndexNavigatorLike {}

// MARK: Navigator Notes
// A protocol, specific to purpose (such as for Product Index)
//      specific navigation methods for this page.

// final class, called "navigator" ie. ProductIndexNavigator
//   example usage methods:
//      showAlert(on vc: UIViewController) {
//          UIAlertController(title msg).show(fromVC: vc)
//       }
//      navigateToScreenB(on vc: UIViewController) {
//          ScreenB.push(a: A, b:B)
//      }
