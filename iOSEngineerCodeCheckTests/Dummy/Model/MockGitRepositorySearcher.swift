//
//  MockGitRepositorySearcher.swift
//  iOSEngineerCodeCheckTests
//  
//  Created by Seigetsu on 2023/12/26
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
@testable import iOSEngineerCodeCheck

class MockGitRepositorySearcher: GitRepositorySearcherProtocol {
    // MARK: Received Argument
    private(set) var query: String?
    
    // MARK: Will Return
    var result: GitRepositorySearchResult
    var returningInterval: TimeInterval
    
    // MARK: メソッド
    init(result: GitRepositorySearchResult, returningInterval: TimeInterval) {
        self.result = result
        self.returningInterval = returningInterval
    }
    
    func search(query: String) async throws -> GitRepositorySearchResult {
        self.query = query
        try await Task.sleep(nanoseconds: UInt64(returningInterval * 1_000_000_000))
        return result
    }
}
