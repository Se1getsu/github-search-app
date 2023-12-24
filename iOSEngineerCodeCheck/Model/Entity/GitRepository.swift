//
//  GitRepository.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/24
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

/// Git リポジトリの情報。
struct GitRepository: Decodable {
    let id: Int
    
    /// リポジトリ名。
    let fullName: String
    
    /// リポジトリのURL。
    let htmlURL: String
    
    /// リポジトリの所有者。
    let owner: GitRepositoryOwner
    
    /// プロジェクト言語。
    let language: String
    
    /// Star 数。
    let stargazersCount: Int
    
    /// Watcher 数。
    let watchersCount: Int
    
    /// Fork 数。
    let forksCount: Int
    
    /// Issue 数。
    let openIssuesCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "full_name"
        case htmlURL = "html_url"
        case owner
        case language
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case forksCount = "forks_count"
        case openIssuesCount = "open_issues_count"
    }
}
