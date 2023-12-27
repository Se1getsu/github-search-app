//
//  GitRepositorySearchQuery.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/27
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

/// Git リポジトリ検索時のクエリパラメータ。
struct GitRepositorySearchQuery {
    /// 1つ以上の検索キーワードと修飾子を含むクエリ。
    var query: String
    /// 検索結果の並び順。
    var sortOption: GitRepositorySortOption
    
    var parameters: [String: String] {
        [
            "q": query,
            "sort": sortOption.rawValue
        ]
    }
}
