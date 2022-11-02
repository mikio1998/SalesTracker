//
//  MainTabBarController.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/21.
//

import Foundation
import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
         setUpViewControllers()
        UITabBar.appearance().tintColor = #colorLiteral(red: 0.9242072701, green: 0.9741521478, blue: 0.8562057018, alpha: 1)
    }
    
    private func setUpViewControllers() {
        // Dependencies inited within class.
        let productIndexViewController = ProductIndexViewController()
        let salesHistoryViewController = SalesHistoryViewController()
        let settingsViewController = SettingsViewController()
        
        if let navigationController = viewControllers?[0] as? UINavigationController {
            navigationController.setViewControllers([productIndexViewController], animated: false)
        }
        if let navigationController = viewControllers?[1] as? UINavigationController {
            navigationController.setViewControllers([salesHistoryViewController], animated: false)
        }
        if let navigationController = viewControllers?[2] as? UINavigationController {
            navigationController.setViewControllers([settingsViewController], animated: false)
        }
    }
    
}


// Notes:

// Shadeview for tab bar?


// viewDidLoad
    // setUpViews perhaps
    // UI stuff for tab bar


// override func tabBar(didselect)
//      if necessary.

// setUpViews
//      Init VCs with dependencies.
//
