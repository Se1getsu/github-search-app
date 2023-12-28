//
//  GitRepositorySearcherProtocol.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/26
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

/// Git リポジトリの検索を行う。
protocol GitRepositorySearcherProtocol {
    /// Git リポジトリの検索を行う。
    func search(query: GitRepositorySearchQuery) async throws -> GitRepositorySearchResult
}
