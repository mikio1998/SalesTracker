//
//  Transitionable.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/19.
//

//    https://stackoverflow.com/questions/46018677/what-is-where-self-in-protocol-extension

import Foundation
import UIKit

protocol Pushable {
    static func push(fromVC: UIViewController, animated: Bool)
}
protocol Presentable {
    static func present(fromVC: UIViewController,
                        animated: Bool,
                        fullscreen: Bool,
                        completion: (() -> Void)?)
    static func presentWithNavigation(fromVC: UIViewController,
                                      animated: Bool,
                                      fullscreen: Bool,
                                      barTintColor: UIColor,
                                      completion: (() -> Void)?)
}

typealias Transitionable = Pushable & Presentable

extension Pushable where Self: UIViewController {
    static func push(fromVC: UIViewController, animated: Bool = true) {
        let vc = Self.loadStoryboard()
        fromVC.navigationController?.pushViewController(vc, animated: animated)
    }

    static func push(fromVC: UIViewController, hidesBottomBar: Bool) {
        let vc = Self.loadStoryboard()
        vc.hidesBottomBarWhenPushed = hidesBottomBar
        fromVC.navigationController?.pushViewController(vc, animated: true)
    }
}

extension Presentable where Self: UIViewController {
    static func present(
        fromVC: UIViewController,
        animated: Bool = true,
        fullScreen: Bool = false,
        completion: (() -> Void)? = nil
    ) {
        let vc = Self.loadStoryboard()
        if fullScreen {
            vc.modalPresentationStyle = .fullScreen
        }
        fromVC.present(vc, animated: animated, completion: completion)
    }

    static func presentWithNavigation(
        fromVC: UIViewController,
        fullScreen: Bool,
        barTintColor: UIColor,
        animated: Bool = true,
        completion: (() -> Void)? = nil
    ) {
        let vc = Self.loadStoryboard()
        let navigation = UINavigationController(rootViewController: vc)
        navigation.navigationBar.tintColor = barTintColor
        navigation.navigationBar.backgroundColor = .white
        navigation.navigationBar.isTranslucent = false
        if fullScreen {
            navigation.modalPresentationStyle = .fullScreen
        }
        fromVC.present(navigation, animated: animated, completion: completion)
    }

    static func presentOver(fromVC: UIViewController) {
        let vc = Self.loadStoryboard()
        vc.modalPresentationStyle = .overFullScreen
        fromVC.present(vc, animated: true, completion: nil)
    }
}
