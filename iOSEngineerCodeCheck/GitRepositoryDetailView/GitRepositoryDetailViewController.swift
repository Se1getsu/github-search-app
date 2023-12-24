//
//  GitRepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class GitRepositoryDetailViewController: UIViewController {
    // MARK: 依存
    private let myView = GitRepositoryDetailView()
    
    // MARK: メソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "[full_name]"
        view = myView
        
        myView.languageLabel.text = "Written in [language]"
        myView.starsLabel.text = "[stargazers_count] stars"
        myView.watchesLabel.text = "[wachers_count] watchers"
        myView.forksLabel.text = "[forks_count] forks"
        myView.issuesLabel.text = "[open_issues_count] open issues"
        getImage()
    }
    
    func getImage() {
        myView.titleLabel.text = "[full_name]"
        Task {
            // TODO: 所有者の画像のURLを指定
            let url = URL(string: "https://avatars.githubusercontent.com/u/10639145?v=4")!
            let image = try await ImageFetcher().fetchImage(from: url)
            await MainActor.run {
                myView.imageView.image = image
            }
        }
    }
}
