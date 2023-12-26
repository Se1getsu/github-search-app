//
//  GitRepositorySearcherTests.swift
//  iOSEngineerCodeCheckTests
//  
//  Created by Seigetsu on 2023/12/26
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class GitRepositorySearcherTests: XCTestCase {
    func test_search() async throws {
        let searcher = GitRepositorySearcher()
        let gitRepositories = try await searcher.search(query: "swift").items
        XCTAssertFalse(gitRepositories.isEmpty)
    }
}
