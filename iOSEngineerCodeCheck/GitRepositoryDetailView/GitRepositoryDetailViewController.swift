//
//  GitRepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class GitRepositoryDetailViewController: UIViewController {
    private typealias ElementID = GitRepositoryDetailViewElementID
    
    // MARK: 依存
    private let myView = GitRepositoryDetailView()
    private let imageFetcher: ImageFetcher
    
    // MARK: 状態
    private var gitRepository: GitRepository
    
    // MARK: メソッド
    init(gitRepository: GitRepository, imageFetcher: ImageFetcher) {
        self.gitRepository = gitRepository
        self.imageFetcher = imageFetcher
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = gitRepository.fullName
        view = myView
        SetUpNavigationBar()
        
        myView.titleLabel.text = gitRepository.fullName
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
        fetchAndShowImage()
    }
    
    private func SetUpNavigationBar() {
        let browseBarButton = UIBarButtonItem(
            image: UIImage(systemName: "safari"),
            style: .plain,
            target: self,
            action: #selector(browseButtonTapped(_:))
        )
        browseBarButton.accessibilityIdentifier = ElementID.browseBarButton
        navigationItem.rightBarButtonItem = browseBarButton
    }
    
    override func viewWillLayoutSubviews() {
        myView.activateLayoutConstraints(frameSize: myView.frame.size)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        myView.activateLayoutConstraints(frameSize: size)
    }
    
    @objc func browseButtonTapped(_ sender: UIBarButtonItem) {
        browse()
    }
    
    private func fetchAndShowImage() {
        Task {
            guard let owner = gitRepository.owner, let url = URL(string: owner.avatarURL) else {
                await setImagePlaceholder(text: "No Image")
                return
            }
            await setImagePlaceholder(text: "画像を取得中…")
            guard let image = try? await imageFetcher.fetchImage(from: url) else {
                await setImagePlaceholder(text: "画像の取得に失敗しました。")
                return
            }
            await setImageView(image: image)
            await setImagePlaceholder(text: "")
        }
    }
    
    private func setImagePlaceholder(text: String) async {
        await MainActor.run {
            myView.imagePlaceholerLabel.text = text
        }
    }
    
    private func setImageView(image: UIImage) async {
        await MainActor.run {
            myView.imageView.image = image
        }
    }
    
    private func browse() {
        let htmlURL = gitRepository.htmlURL
        guard let url = URL(string: htmlURL) else { return }
        UIApplication.shared.open(url)
    }
}
