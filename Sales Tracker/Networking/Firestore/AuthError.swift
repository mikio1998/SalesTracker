//
//  AuthError.swift
//  Sales Tracker
//
//  Created by Mikio Nakata on 2022/10/31.
//

import Foundation

enum AuthError: Error {
    case emptyFieldError
    case loginError
    case logoutError

    var message: String {
        switch self {
        case .emptyFieldError:
            return "メールとパスを入力してください！"
        case .loginError:
            return "ログインが失敗しました。"
        case .logoutError:
            return "ログアウトが失敗しました。"
        }
    }
}
