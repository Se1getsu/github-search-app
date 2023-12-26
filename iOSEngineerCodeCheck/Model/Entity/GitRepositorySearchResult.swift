//
//  GitRepositorySearchResult.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/26
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

/// Git リポジトリの検索結果。
struct GitRepositorySearchResult: Decodable {
    let items: [GitRepository]
}
