//
//  GitRepositoryListPresenter.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/24
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

final class GitRepositoryListPresenter {
    // MARK: 依存
    private weak var view: GitRepositoryListPresenterOutput!
    
    // MARK: 状態
    private(set) var gitRepositories: [GitRepository] = []
    private let gitRepositorySearcher = GitRepositorySearcher()
    private(set) var searchingTask: Task<(), Never>?
    
    // MARK: メソッド
    init(view: GitRepositoryListPresenterOutput) {
        self.view = view
    }
}

extension GitRepositoryListPresenter: GitRepositoryListPresenterInput {
    func searchBar(textDidChange searchText: String) {
        searchingTask?.cancel()
    }
    
    func searchBarSearchButtonClicked(searchText: String) {
        guard !searchText.isEmpty else { return }
        searchingTask = Task {
            do {
                let gitRepositories = try await gitRepositorySearcher.search(query: searchText).items
                await MainActor.run {
                    self.gitRepositories = gitRepositories
                    view.reloadGitRepositories()
                }
            } catch {
                if Task.isCancelled {
                    // TODO: タスクがキャンセルされた時の処理
                    
                } else {
                    // TODO: エラーハンドリング
                    print(error)
                }
            }
        }
    }
}
