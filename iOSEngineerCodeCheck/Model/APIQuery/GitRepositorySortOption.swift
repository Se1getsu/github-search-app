//
//  GitRepositorySortOption.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/27
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

/// GIt リポジトリの並び順。
enum GitRepositorySortOption: String {
    case bestMatch = ""
    case stars = "stars"
    case forks = "forks"
    case updated = "updated"
    
    /// 選択肢としてユーザーに表示する文字列。
    var description: String {
        switch self {
        case .bestMatch:    "関連性の高い順"
        case .stars:        "スターの多い順"
        case .forks:        "フォークの多い順"
        case .updated:      "更新が新しい順"
        }
    }
}
