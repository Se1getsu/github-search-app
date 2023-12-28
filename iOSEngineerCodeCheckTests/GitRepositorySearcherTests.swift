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
    func test_search_bestMatch() async throws {
        let searcher = GitRepositorySearcher()
        let query = GitRepositorySearchQuery(
            query: "swift",
            sortOption: .bestMatch
        )
        let gitRepositories = try await searcher.search(query: query).items
        XCTAssertFalse(gitRepositories.isEmpty)
    }
    
    func test_search_stars() async throws {
        let searcher = GitRepositorySearcher()
        let query = GitRepositorySearchQuery(
            query: "swift",
            sortOption: .stars
        )
        let gitRepositories = try await searcher.search(query: query).items
        XCTAssertFalse(gitRepositories.isEmpty)
    }
    
    func test_search_forks() async throws {
        let searcher = GitRepositorySearcher()
        let query = GitRepositorySearchQuery(
            query: "swift",
            sortOption: .forks
        )
        let gitRepositories = try await searcher.search(query: query).items
        XCTAssertFalse(gitRepositories.isEmpty)
    }
    
    func test_search_updated() async throws {
        let searcher = GitRepositorySearcher()
        let query = GitRepositorySearchQuery(
            query: "swift",
            sortOption: .updated
        )
        let gitRepositories = try await searcher.search(query: query).items
        XCTAssertFalse(gitRepositories.isEmpty)
    }
}
