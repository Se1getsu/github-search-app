//
//  APIError.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/25
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

enum APIError: LocalizedError {
    case notConnectedToInternet
    case unknownError(Error)
    
    /// アラートのタイトルとして表示する文字列
    var localizedDescription: String {
        switch self {
        case .notConnectedToInternet:
            "インターネット未接続"
        case .unknownError:
            "未知のエラー"
        }
    }
    
    /// アラートのメッセージとして表示する文字列
    var recoverySuggestion: String? {
        switch self {
        case .notConnectedToInternet:
            "端末がオフラインのようです。\nインターネットに接続してから再度お試しください。"
        case .unknownError(let error as NSError):
            "原因不明のエラーが発生しました。\nエラーコード: \(error.code)"
        }
    }
    
    /// 与えられたAPI関連のエラーから、エラー種別を分類する。
    static func classify(_ error: Error) -> Self {
        switch error.asAFError {
        case .sessionTaskFailed(let error as NSError):
            if error.code == NSURLErrorNotConnectedToInternet {
                return .notConnectedToInternet
            }
            return .unknownError(error)
            
        default:
            return .unknownError(error)
        }
    }
}
