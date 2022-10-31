//
//  Hello.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/31.
//

import Foundation

enum Hello {
    case morning, day, evening, otsukare
    
    var title: String {
        switch self {
        case .morning:
            return "おはようございます。"
        case .day:
            return "こんにちは。"
        case .evening:
            return "こんばんは。"
        case .otsukare:
            return "お疲れ様です。"
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
        case Const.otsukareRange:
            self = .otsukare
        default:
            self = .evening
        }
    }
}
extension Hello {
    private enum Const {
        static let morningRange: Range = 5..<11
        static let dayRange: Range = 11..<17
//        static let eveningRange: Range = [17..<18, 20..<24, 0..<5].joined()
        static let otsukareRange: Range = 18..<20
    }
}
