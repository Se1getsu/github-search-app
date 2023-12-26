//
//  DummyGitRepositoryMaker.swift
//  iOSEngineerCodeCheckTests
//  
//  Created by Seigetsu on 2023/12/26
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
@testable import iOSEngineerCodeCheck

struct DummyGitRepositoryMaker {
    /// ランダムなIDの GitRepository を生成する。
    static func make() -> GitRepository {
        GitRepository(
            id: Int.random(in: 1...1_000_000),
            fullName: "sample/repository",
            htmlURL: "https://example.com",
            owner: GitRepositoryOwner(
                id: 100,
                login: "sample",
                avatarURL: "https://avatars.githubusercontent.com/u/9919?s=200&v=4"
            ),
            language: "Java",
            stargazersCount: 314,
            watchersCount: 15,
            forksCount: 92,
            openIssuesCount: 65
        )
    }
    
    /// ランダムなIDの GitRepository を指定した個数生成する。
    static func make(count: Int) -> [GitRepository] {
        (1...count).map { _ in make() }
    }
}
