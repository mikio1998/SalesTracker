//
//  Hello.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/31.
//

import Foundation
import UIKit

enum Hello {
    case morning, day, evening
    
    var title: String {
        switch self {
        case .morning:
            return "おはようございます。"
        case .day:
            return "こんにちは。"
        case .evening:
            return "こんばんは。"
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .morning:
            return #colorLiteral(red: 0.02142922208, green: 0.08387541026, blue: 0.1793012023, alpha: 1)
        case .day:
            return #colorLiteral(red: 0.02142922208, green: 0.08387541026, blue: 0.1793012023, alpha: 1)
        case .evening:
            return #colorLiteral(red: 0.0184539333, green: 0.08078091592, blue: 0.1796725094, alpha: 1)
        }
    }
}
extension Hello {
    init(hour: Int) {
        switch hour {
        case Const.morningRange:
            self = .morning
        case Const.dayRange:
            self = .day
        default:
            self = .evening
        }
    }
}
extension Hello {
    private enum Const {
        static let morningRange: Range = 5..<11
        static let dayRange: Range = 11..<17
    }
}
