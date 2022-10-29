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
            return "アルファ"
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
    
    var brandLogoUrl: String {
        switch self {
        case .TestBrand:
            return
            "https://user-images.githubusercontent.com/1567433/114792417-57c1d080-9d56-11eb-8035-dc07cfd7557f.png"
        case .AlphaIndustries:
            return
            "https://www.nakatashoten.com/img-item/logomark-alpha.gif"
        }
    }
}
