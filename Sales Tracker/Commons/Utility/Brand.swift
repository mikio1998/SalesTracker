//
//  Brand.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/22.
//

import Foundation
import UIKit

enum Brand {
    case testBrand
    case alphaIndustries
    case avirex
    case helikonTex
    case houston
    case sessler
    case truSpec
    case valleyApparel
    case cockpit
    case usSurplus

    init(name: String) {
        switch name {
        case "Alpha Industries":
            self = .alphaIndustries
        case "AVIREX":
            self = .avirex
        case "Helikon Tex":
            self = .helikonTex
        case "Houston":
            self = .houston
        case "Sessler":
            self = .sessler
        case "TruSpec":
            self = .truSpec
        case "Valley Apparel":
            self = .valleyApparel
        case "US Surplus":
            self = .usSurplus
        case "Cockpit":
            self = .cockpit
        default:
            self = .testBrand
        }
    }

    var collectionName: String {
        switch self {
        case .testBrand:
            return "products"
        case .alphaIndustries:
            return "Alpha Industries"
        case .avirex:
            return "AVIREX"
        case .helikonTex:
            return "Helikon Tex"
        case .houston:
            return "Houston"
        case .sessler:
            return "Sessler"
        case .truSpec:
            return "Tru Spec"
        case .valleyApparel:
            return "Valley Apparel"
        case .cockpit:
            return "Cockpit"
        case .usSurplus:
            return "US Surplus"
        }
    }

    var officialBrandName: String {
        switch self {
        case .testBrand:
            return "Test Brand"
        case .alphaIndustries:
            return "アルファ"
        case .avirex:
            return "アビレックス"
        case .helikonTex:
            return "ヘリコンテックス"
        case .houston:
            return "ヒューストン"
        case .sessler:
            return "セスラー"
        case .truSpec:
            return "トルースペック"
        case .valleyApparel:
            return "バレーアパレル"
        case .cockpit:
            return "コックピット"
        case .usSurplus:
            return "米軍放出品"
        }
    }

    var brandColor: UIColor {
        switch self {
        case .testBrand:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .alphaIndustries:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .avirex:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .helikonTex:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .houston:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .sessler:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .truSpec:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .valleyApparel:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .cockpit:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        case .usSurplus:
            return #colorLiteral(red: 0, green: 0.2980392157, blue: 0.4, alpha: 1)
        }
    }

    var brandLogoUrl: String {
        switch self {
        case .testBrand:
            return "https://user-images.githubusercontent.com/1567433/114792417-57c1d080-9d56-11eb-8035-dc07cfd7557f.png"
        case .alphaIndustries:
            return "https://www.nakatashoten.com/img-item/logomark-alpha.gif"
        case .avirex:
            return "https://www.nakatashoten.com/img/logo-avirex_s.gif"
        case .helikonTex:
            return "https://www.nakatashoten.com/images/helikontex/logo_helikontex.png"
        case .houston:
            return "https://www.nakatashoten.com/img-item/icon-houston.gif"
        case .sessler:
            return "https://www.nakatashoten.com/img-item/logo-sessler2.gif"
        case .truSpec:
            return "https://www.nakatashoten.com/img-item/logo-tru-spec-atlanco.gif"
        case .valleyApparel:
            return "https://www.nakatashoten.com/img-item/logo-va.gif"
        case .cockpit:
            return "https://www.nakatashoten.com/img-item/logo-cockpit-2.gif"
        case .usSurplus:
            return "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/US_Army_Star_Logo_SSI.png/1200px-US_Army_Star_Logo_SSI.png"
        }
    }
}
