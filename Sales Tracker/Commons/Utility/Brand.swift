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
    case Avirex
    case HelikonTex
    case Houston
    case Sessler
    case TruSpec
    case ValleyApparel
    case USSurplus
    
    init(name: String) {
        switch name {
        case "Alpha Industries":
            self = .AlphaIndustries
        case "AVIREX":
            self = .Avirex
        case "Helikon Tex":
            self = .HelikonTex
        case "Houston":
            self = .Houston
        case "Sessler":
            self = .Sessler
        case "TruSpec":
            self = .TruSpec
        case "Valley Apparel":
            self = .ValleyApparel
        case "US Surplus":
            self = .USSurplus
        default:
            self = .TestBrand
        }
    }
    
    var collectionName: String {
        switch self {
        case .TestBrand:
            return "products"
        case .AlphaIndustries:
            return "Alpha Industries"
        case .Avirex:
            return "AVIREX"
        case .HelikonTex:
            return "Helikon Tex"
        case .Houston:
            return "Houston"
        case .Sessler:
            return "Sessler"
        case .TruSpec:
            return "Tru Spec"
        case .ValleyApparel:
            return "Valley Apparel"
        case .USSurplus:
            return "US Surplus"
        }
    }
    
    
    var officialBrandName: String {
        switch self {
        case .TestBrand:
            return "Test Brand"
        case .AlphaIndustries:
            return "アルファ"
        case .Avirex:
            return "アビレックス"
        case .HelikonTex:
            return "ヘリコンテックス"
        case .Houston:
            return "ヒューストン"
        case .Sessler:
            return "セスラー"
        case .TruSpec:
            return "トルースペック"
        case .ValleyApparel:
            return "バレーアパレル"
        case .USSurplus:
            return "米軍放出品"
        }
    }
    
    var brandColor: UIColor {
        switch self {
        case .TestBrand:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .AlphaIndustries:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .Avirex:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .HelikonTex:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .Houston:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .Sessler:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .TruSpec:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .ValleyApparel:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .USSurplus:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        }
    }
    
    var brandLogoUrl: String {
        switch self {
        case .TestBrand:
            return "https://user-images.githubusercontent.com/1567433/114792417-57c1d080-9d56-11eb-8035-dc07cfd7557f.png"
        case .AlphaIndustries:
            return "https://www.nakatashoten.com/img-item/logomark-alpha.gif"
        case .Avirex:
            return "https://www.nakatashoten.com/img/logo-avirex_s.gif"
        case .HelikonTex:
            return "https://www.nakatashoten.com/images/helikontex/logo_helikontex.png"
        case .Houston:
            return "https://www.nakatashoten.com/img-item/icon-houston.gif"
        case .Sessler:
            return "https://www.nakatashoten.com/img-item/logo-sessler2.gif"
        case .TruSpec:
            return "https://www.nakatashoten.com/img-item/logo-tru-spec-atlanco.gif"
        case .ValleyApparel:
            return "https://www.nakatashoten.com/img-item/logo-va.gif"
        case .USSurplus:
            return "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/US_Army_Star_Logo_SSI.png/1200px-US_Army_Star_Logo_SSI.png"
        }
    }
}
