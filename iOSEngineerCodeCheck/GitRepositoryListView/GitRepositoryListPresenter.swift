//
//  GitRepositoryListPresenter.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/24
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
import Combine

final class GitRepositoryListPresenter {
    // MARK: 依存
    private weak var view: GitRepositoryListPresenterOutput!
    private let gitRepositorySearcher: GitRepositorySearcherProtocol
    
    // MARK: 状態
    private(set) var gitRepositories: [GitRepository] = []
    private var searchingTask: Task<(), Never>?
    private var textWillSearch: String?
    private var textDidSearch: String?
    
    // MARK: メソッド
    init(view: GitRepositoryListPresenterOutput, gitRepositorySearcher: GitRepositorySearcherProtocol) {
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

extension GitRepositoryListPresenter: GitRepositoryListPresenterInput {
    func searchBar(textDidChange searchText: String) {
        searchingTask?.cancel()
    }
    
    func searchBarSearchButtonClicked(searchText: String) {
        guard !searchText.isEmpty else { return }
        searchingTask = Task {
            do {
                await willSearch(searchText: searchText)
                let query = GitRepositorySearchQuery(query: searchText, sortOption: .bestMatch)
                let gitRepositories = try await gitRepositorySearcher.search(query: query).items
                await didSearch(searchText: searchText, result: gitRepositories)
            } catch {
                if Task.isCancelled {
                    await MainActor.run {
                        view.stopActivityIndicator()
                    }
                } else {
                    await displayErrorAlert(error: error)
                }
            }
        }
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
