//
//  Brand.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/22.
//

import Foundation
import UIKit

enum Brand {
    case TestBrand
    case AlphaIndustries
    
    
    var collectionName: String {
        switch self {
        case .TestBrand:
            return "products"
        case .AlphaIndustries:
            return "Alpha Industries"
        }
    }
    var officialBrandName: String {
        switch self {
        case .TestBrand:
            return "Test Brand"
        case .AlphaIndustries:
            return "Alpha Industries"
        }
    }
    
    var brandColor: UIColor {
        switch self {
        case .TestBrand:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .AlphaIndustries:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        }
    }
}
