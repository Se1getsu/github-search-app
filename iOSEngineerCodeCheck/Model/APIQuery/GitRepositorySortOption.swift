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
}
