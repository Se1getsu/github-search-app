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
    private var searchingTask: Task<(), Never>?
    private var searchText: String?
    
    // MARK: メソッド
    init(view: GitRepositoryListPresenterOutput) {
        self.view = view
    }
    
    private func displayErrorAlert(error: Error) async {
        if let error = error as? APIError {
            await MainActor.run {
                view.showRetryOrCancelAlert(
                    title: error.localizedDescription,
                    message: error.recoverySuggestion
                )
            }
        } else {
            await MainActor.run {
                view.showRetryOrCancelAlert(
                    title: "予期せぬエラーが発生しました",
                    message: "エラーコード: \((error as NSError).code)"
                )
            }
        }
    }
}

extension GitRepositoryListPresenter: GitRepositoryListPresenterInput {
    func searchBar(textDidChange searchText: String) {
        searchingTask?.cancel()
    }
    
    func searchBarSearchButtonClicked(searchText: String) {
        guard !searchText.isEmpty else { return }
        self.searchText = searchText
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
                    await displayErrorAlert(error: error)
                }
            }
        }
    }
    
    func alertRetrySelected() {
        guard let searchText else { return }
        searchBarSearchButtonClicked(searchText: searchText)
    }
    
    func alertCancelSelected() {
        // TODO: キャンセルされた時の処理
    }
}
