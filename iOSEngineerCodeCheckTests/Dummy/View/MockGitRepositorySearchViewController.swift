//
//  MockGitRepositorySearchViewController.swift
//  iOSEngineerCodeCheckTests
//  
//  Created by Seigetsu on 2023/12/26
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation
@testable import iOSEngineerCodeCheck

class MockGitRepositorySearchViewController: GitRepositorySearchPresenterOutput {
    // MARK: Presenter
    private var presenter: GitRepositorySearchPresenterInput!
    
    // MARK: Called Flag
    private(set) var searchBarEndEditingCalled = false
    
    // MARK: Received Argument
    private(set) var showRetryOrCancelAlertArguments: (title: String, message: String?)?
    private(set) var searchBarUpdatedText: String?
    
    // MARK: 状態
    var gitRepositories: [GitRepository]?
    var activityIndicatorAnimating = false
    var showingNoResultView = false
    var showingGuidance = true
    
    // MARK: メソッド
    func inject(presenter: GitRepositorySearchPresenterInput) {
        self.presenter = presenter
    }
    
    func reloadGitRepositories() {
        gitRepositories = presenter.gitRepositories
    }
    
    func showRetryOrCancelAlert(title: String, message: String?) {
        showRetryOrCancelAlertArguments = (title: title, message: message)
    }
    
    func startActivityIndicator() {
        activityIndicatorAnimating = true
    }
    
    func stopActivityIndicator() {
        activityIndicatorAnimating = false
    }
    
    func searchBarEndEditing() {
        searchBarEndEditingCalled = true
    }
    
    func searchBarUpdateSearchText(_ searchText: String) {
        searchBarUpdatedText = searchText
    }
    
    func showNoResultView() {
        showingNoResultView = true
    }
    
    func hideNoResultView() {
        showingNoResultView = false
    }
    
    func hideGuidance() {
        showingGuidance = false
    }
    
    func showGuidance() {
        showingGuidance = true
    }
}
