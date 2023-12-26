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
    // MARK: Called Count
    private(set) var searchCalledCount = 0
    
    // MARK: Received Argument
    private(set) var query: String?
    
    // MARK: Will Return
    var result: Result<GitRepositorySearchResult, Error>
    var returningInterval: TimeInterval
    
    // MARK: メソッド
    init(result: Result<GitRepositorySearchResult, Error>, returningInterval: TimeInterval) {
        self.result = result
        self.returningInterval = returningInterval
    }
    
    /// Called Count と Received Argument の情報をリセットする。
    func resetCallInfo() {
        searchCalledCount = 0
        query = nil
    }
    
    func search(query: String) async throws -> GitRepositorySearchResult {
        searchCalledCount += 1
        self.query = query
        try await Task.sleep(nanoseconds: UInt64(returningInterval * 1_000_000_000))
        switch result {
        case .success(let result):
            return result
        case .failure(let error):
            throw error
        }
    }
}
