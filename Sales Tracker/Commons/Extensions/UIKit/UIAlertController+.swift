//
//  UIAlertController+.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/30.
//

import Foundation
import UIKit

extension UIAlertController {
    func addCancel(handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        let action = UIAlertAction(title: "キャンセル", style: .cancel, handler: handler)
        self.addAction(action)
        return self
    }
    func addOK(handler: ((UIAlertAction) -> Void)? = nil) -> Self {
        let action = UIAlertAction(title: "OK", style: .default, handler: handler)
        self.addAction(action)
        return self
    }
    func add(title: String, style: UIAlertAction.Style = .default, handler: ((UIAlertAction) -> Void)?) -> Self {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        self.addAction(action)
        return self
    }

    func show(fromVC: UIViewController) {
        fromVC.present(self, animated: true, completion: nil)
    }

    func showAndDismiss(fromVC: UIViewController, deadline: DispatchTime, completion: (() -> Void)?) {
        fromVC.present(self, animated: true) {
            DispatchQueue.main.asyncAfter(deadline: deadline) {
                self.dismiss(animated: true, completion: completion)
            }
        }
    }
    
    
}
