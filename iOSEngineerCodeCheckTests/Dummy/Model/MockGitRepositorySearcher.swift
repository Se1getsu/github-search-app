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
    
    // MARK: メソッド
    init(result: GitRepositorySearchResult) {
        self.result = result
    }
    
    func search(query: String) async throws -> GitRepositorySearchResult {
        self.query = query
        return result
    }
}
