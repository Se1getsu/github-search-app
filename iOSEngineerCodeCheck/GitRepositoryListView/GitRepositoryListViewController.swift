//
//  GitRepositoryListViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class GitRepositoryListViewController: UIViewController {
    // MARK: UI
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "GitHubのリポジトリを検索"
        searchBar.showsCancelButton = false
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .large
        return activityIndicatorView
    }()
    
    private let noResultView: NoResultView = {
        let noResultView = NoResultView()
        noResultView.isHidden = true
        return noResultView
    }()
    
    // MARK: 依存
    private var presenter: GitRepositoryListPresenterInput!
    
    // MARK: メソッド
    func inject(presenter: GitRepositoryListPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "リポジトリ検索"
        view.backgroundColor = .systemBackground
        
        noResultView.center = view.center
        activityIndicatorView.center = view.center
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(activityIndicatorView)
        view.addSubview(noResultView)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
    }
}

extension GitRepositoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.gitRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let gitRepository = presenter.gitRepositories[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = gitRepository.fullName
        content.secondaryText = gitRepository.language ?? "言語なし"
        cell.contentConfiguration = content
        return cell
    }
}

extension GitRepositoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = GitRepositoryDetailViewController(
            gitRepository: presenter.gitRepositories[indexPath.row],
            imageFetcher: ImageFetcher()
        )
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension GitRepositoryListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter.searchBar(textDidChange: searchText)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        presenter.searchBarSearchButtonClicked(searchText: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        presenter.searchBarCancelButtonClicked()
    }
}

extension GitRepositoryListViewController: GitRepositoryListPresenterOutput {
    func showRetryOrCancelAlert(title: String, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retry = UIAlertAction(title: "再試行", style: .default) { _ in
            self.presenter.alertRetrySelected()
        }
        let cancel = UIAlertAction(title: "キャンセル", style: .cancel) { _ in
            self.presenter.alertCancelSelected()
        }
        alert.addAction(retry)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    func reloadGitRepositories() {
        tableView.reloadData()
    }
    
    func startActivityIndicator() {
        activityIndicatorView.startAnimating()
    }
    
    func stopActivityIndicator() {
        activityIndicatorView.stopAnimating()
    }
    
    func searchBarEndEditing() {
        searchBar.endEditing(true)
    }
    
    func searchBarUpdateSearchText(_ searchText: String) {
        searchBar.text = searchText
    }
    
    func showNoResultView() {
        noResultView.isHidden = false
    }
    
    func hideNoResultView() {
        noResultView.isHidden = true
    }
}

#Preview("UIKit") {
    let vc = GitRepositoryListViewController()
    let presenter = GitRepositoryListPresenter(
        view: vc,
        gitRepositorySearcher: GitRepositorySearcher()
    )
    vc.inject(presenter: presenter)
    return UINavigationController(rootViewController: vc)
}
