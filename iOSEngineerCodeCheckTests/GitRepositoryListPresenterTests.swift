//
//  GitRepositoryListPresenterTests.swift
//  iOSEngineerCodeCheckTests
//  
//  Created by Seigetsu on 2023/12/26
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import XCTest
@testable import iOSEngineerCodeCheck

final class GitRepositoryListPresenterTests: XCTestCase {
    // MARK: テスト対象
    private var presenter: GitRepositoryListPresenter!
    
    // MARK: ダミー
    private var view: MockGitRepositoryListViewController!
    private var gitRepositorySearcher: MockGitRepositorySearcher!
    private var dummyGitRepositories = DummyGitRepositoryMaker.make(count: 3)
    
    // MARK: セットアップ
    override func setUp() {
        view = MockGitRepositoryListViewController()
        gitRepositorySearcher = MockGitRepositorySearcher(
            result: .success(
                GitRepositorySearchResult(
                    items: dummyGitRepositories
                )
            ),
            returningInterval: 0.1
        )
        presenter = GitRepositoryListPresenter(
            view: view,
            gitRepositorySearcher: gitRepositorySearcher
        )
        view.inject(presenter: presenter)
    }
    
    override func tearDown() {
        presenter = nil
        view = nil
        gitRepositorySearcher = nil
        super.tearDown()
    }
    
    // MARK: テスト
    func test_検索_成功() {
        let searchText = "sample"
        presenter.searchBarSearchButtonClicked(searchText: searchText)
        
        _ = XCTWaiter.wait(for: [expectation(description: "Viewが読み込み状態になるまで待機")], timeout: 0.05)
        XCTAssertEqual(gitRepositorySearcher.query, searchText)
        XCTAssertTrue(view.searchBarEndEditingCalled)
        XCTAssertFalse(view.showingGuidance)
        XCTAssertTrue(view.activityIndicatorAnimating)
        
        _ = XCTWaiter.wait(for: [expectation(description: "読み込みが完了するまで待機")], timeout: 0.15)
        XCTAssertEqual(view.gitRepositories?.count, 3)
        XCTAssertFalse(view.activityIndicatorAnimating)
    }
    
    func test_検索_APIエラー() {
        let searchText = "sample"
        let error = NetworkError.notConnectedToInternet
        gitRepositorySearcher.result = .failure(error)
        gitRepositorySearcher.returningInterval = 0.05
        presenter.searchBarSearchButtonClicked(searchText: searchText)
        
        _ = XCTWaiter.wait(for: [expectation(description: "結果がViewに反映されるまで待機")], timeout: 0.1)
        let alert = view.showRetryOrCancelAlertArguments
        XCTAssertNotNil(alert)
        XCTAssertEqual(alert!.title, error.localizedDescription)
        XCTAssertEqual(alert!.message, error.recoverySuggestion)
    }
    
    func test_検索_予期せぬエラー() {
        let searchText = "sample"
        let error = NSError(domain: "TestDomain", code: 123)
        gitRepositorySearcher.result = .failure(error)
        gitRepositorySearcher.returningInterval = 0.05
        presenter.searchBarSearchButtonClicked(searchText: searchText)
        
        _ = XCTWaiter.wait(for: [expectation(description: "結果がViewに反映されるまで待機")], timeout: 0.1)
        let alert = view.showRetryOrCancelAlertArguments
        XCTAssertNotNil(alert)
        XCTAssertEqual(alert!.title, "予期せぬエラーが発生しました")
        XCTAssertEqual(alert!.message, "エラーコード: 123")
    }
    
    func test_検索完了前に検索テキストを変更するとキャンセル() {
        let searchText = "sample"
        presenter.searchBarSearchButtonClicked(searchText: searchText)
        
        _ = XCTWaiter.wait(for: [expectation(description: "Viewが読み込み状態になるまで待機")], timeout: 0.05)
        presenter.searchBar(textDidChange: "sampl")
        
        _ = XCTWaiter.wait(for: [expectation(description: "結果がViewに反映されるまで待機")], timeout: 0.1)
        XCTAssertNil(view.gitRepositories)
        XCTAssertFalse(view.activityIndicatorAnimating)
    }
    
    func test_キャンセルボタンの処理_パターン1() {
        presenter.searchBarCancelButtonClicked()
        
        _ = XCTWaiter.wait(for: [expectation(description: "結果がViewに反映されるまで待機")], timeout: 0.05)
        XCTAssertEqual(view.searchBarUpdatedText, "")
        XCTAssertTrue(view.searchBarEndEditingCalled)
    }
        
    func test_キャンセルボタンの処理_パターン2() {
        let searchText = "sample"
        gitRepositorySearcher.returningInterval = 0.0
        presenter.searchBarSearchButtonClicked(searchText: searchText)
        
        _ = XCTWaiter.wait(for: [expectation(description: "結果がViewに反映されるまで待機")], timeout: 0.05)
        presenter.searchBar(textDidChange: "test")
        presenter.searchBarCancelButtonClicked()
        
        _ = XCTWaiter.wait(for: [expectation(description: "結果がViewに反映されるまで待機")], timeout: 0.05)
        XCTAssertEqual(view.searchBarUpdatedText, searchText)
        XCTAssertTrue(view.searchBarEndEditingCalled)
    }
    
    func test_アラート_再試行() {
        let searchText = "sample"
        let error = NetworkError.notConnectedToInternet
        gitRepositorySearcher.result = .failure(error)
        gitRepositorySearcher.returningInterval = 0.0
        presenter.searchBarSearchButtonClicked(searchText: searchText)
        
        _ = XCTWaiter.wait(for: [expectation(description: "結果がViewに反映されるまで待機")], timeout: 0.05)
        gitRepositorySearcher.result = .success(
            GitRepositorySearchResult(items: dummyGitRepositories)
        )
        gitRepositorySearcher.returningInterval = 0.1
        gitRepositorySearcher.resetCallInfo()   // リセット
        view.gitRepositories = nil              // リセット
        presenter.alertRetrySelected()
        
        _ = XCTWaiter.wait(for: [expectation(description: "Viewが読み込み状態になるまで待機")], timeout: 0.05)
        XCTAssertEqual(gitRepositorySearcher.query, searchText)
        XCTAssertTrue(view.activityIndicatorAnimating)
        
        _ = XCTWaiter.wait(for: [expectation(description: "読み込みが完了するまで待機")], timeout: 0.1)
        XCTAssertEqual(view.gitRepositories?.count, 3)
        XCTAssertFalse(view.activityIndicatorAnimating)
    }
    
    func test_アラート_キャンセル() {
        let searchText = "sample"
        let error = NetworkError.notConnectedToInternet
        gitRepositorySearcher.result = .failure(error)
        gitRepositorySearcher.returningInterval = 0.0
        presenter.searchBarSearchButtonClicked(searchText: searchText)
        
        _ = XCTWaiter.wait(for: [expectation(description: "結果がViewに反映されるまで待機")], timeout: 0.05)
        gitRepositorySearcher.result = .success(
            GitRepositorySearchResult(items: dummyGitRepositories)
        )
        presenter.alertCancelSelected()
        
        _ = XCTWaiter.wait(for: [expectation(description: "Viewが読み込み状態になるまで待機")], timeout: 0.05)
        XCTAssertFalse(view.activityIndicatorAnimating)
    }
}
