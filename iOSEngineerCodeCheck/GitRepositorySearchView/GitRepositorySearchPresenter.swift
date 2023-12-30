//
//  GitRepositorySearchPresenter.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/24
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import Combine

final class GitRepositorySearchPresenter {
    // MARK: 依存
    private weak var view: GitRepositorySearchPresenterOutput!
    private let gitRepositorySearcher: GitRepositorySearcherProtocol
    
    // MARK: 状態
    private(set) var gitRepositories: [GitRepository] = []
    private(set) var sortOption: GitRepositorySortOption = .bestMatch
    private var searchingTask: Task<(), Never>?
    private var textWillSearch: String?
    private var textDidSearch: String?
    
    // MARK: メソッド
    init(view: GitRepositorySearchPresenterOutput, gitRepositorySearcher: GitRepositorySearcherProtocol) {
        self.view = view
        self.gitRepositorySearcher = gitRepositorySearcher
    }
    
    private func displayErrorAlert(error: Error) async {
        if let error = error as? NetworkError {
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
    
    private func updateGitRepositoriesOnView() {
        view.reloadGitRepositories()
        if gitRepositories.isEmpty {
            view.showNoResultView()
        } else {
            view.hideNoResultView()
        }
    }
    
    /// Git リポジトリ検索処理。
    private func search(searchText: String) {
        searchingTask = Task {
            do {
                await willSearch(searchText: searchText)
                let query = GitRepositorySearchQuery(query: searchText, sortOption: sortOption)
                let gitRepositories = try await gitRepositorySearcher.search(query: query).items
                await didSearch(searchText: searchText, result: gitRepositories)
            } catch {
                guard !Task.isCancelled else { return }
                await displayErrorAlert(error: error)
            }
        }
    }
    
    /// 検索開始時に行う処理。
    private func willSearch(searchText: String) async {
        await MainActor.run {
            textWillSearch = searchText
            view.searchBarEndEditing()
            view.hideGuidance()
            view.startActivityIndicator()
        }
    }
    
    /// 検索完了時に行う処理。
    private func didSearch(searchText: String, result gitRepositories: [GitRepository]) async {
        await MainActor.run {
            self.gitRepositories = gitRepositories
            updateGitRepositoriesOnView()
            view.stopActivityIndicator()
            textDidSearch = searchText
        }
    }
}

extension GitRepositorySearchPresenter: GitRepositorySearchPresenterInput {
    func didSelectSortOption(_ sortOption: GitRepositorySortOption) {
        self.sortOption = sortOption
        searchingTask?.cancel()
        if let textWillSearch {
            search(searchText: textWillSearch)
        }
    }
    
    func searchBar(textDidChange searchText: String) {
        searchingTask?.cancel()
        Task {
            await MainActor.run {
                view.stopActivityIndicator()
            }
        }
    }
    
    func searchBarSearchButtonClicked(searchText: String) {
        guard !searchText.isEmpty else { return }
        search(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked() {
        Task {
            await MainActor.run {
                view.searchBarUpdateSearchText(textDidSearch ?? "")
                view.searchBarEndEditing()
            }
        }
    }
    
    func alertRetrySelected() {
        guard let textWillSearch else { return }
        searchBarSearchButtonClicked(searchText: textWillSearch)
    }
    
    func alertCancelSelected() {
        Task {
            await MainActor.run {
                view.stopActivityIndicator()
            }
        }
    }
}
