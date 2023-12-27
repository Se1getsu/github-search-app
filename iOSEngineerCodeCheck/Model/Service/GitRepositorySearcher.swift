//
//  GitRepositorySearcher.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/24
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Alamofire
import Foundation

/// GitHubAPI を呼び出して Git リポジトリの検索を行う。
struct GitRepositorySearcher: GitRepositorySearcherProtocol {
    func search(query: String) async throws -> GitRepositorySearchResult {
        let url = "https://api.github.com/search/repositories"
        let parameters = [
            "q": query
        ]
        let headers: HTTPHeaders = [
            "Accept": "application/vnd.github+json",
            "X-GitHub-Api-Version": "2022-11-28"
        ]
        let response = await AF.request(url, parameters: parameters, headers: headers)
            .serializingDecodable(GitRepositorySearchResult.self)
            .response
        
        switch response.result {
        case .success(let data):
            return data
            
        case .failure(let error):
            throw NetworkError.classify(error)
        }
    }
}
