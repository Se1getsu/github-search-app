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
    
    // MARK: 状態
    private var gitRepository: GitRepository
    
    // MARK: メソッド
    init(gitRepository: GitRepository) {
        self.gitRepository = gitRepository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = gitRepository.fullName
        view = myView
        
        myView.languageLabel.text = {
            if let language = gitRepository.language {
                "Written in \(language)"
            } else {
                "No Language"
            }
        }()
        myView.starsLabel.text = "\(gitRepository.stargazersCount) stars"
        myView.watchesLabel.text = "\(gitRepository.watchersCount) watchers"
        myView.forksLabel.text = "\(gitRepository.forksCount) forks"
        myView.issuesLabel.text = "\(gitRepository.openIssuesCount) open issues"
        getImage()
    }
    
    func getImage() {
        myView.titleLabel.text = gitRepository.fullName
        guard let owner = gitRepository.owner, let url = URL(string: owner.avatarURL) else { return }
        Task {
            let image = try await ImageFetcher().fetchImage(from: url)
            await MainActor.run {
                myView.imageView.image = image
            }
        }
    }
}
