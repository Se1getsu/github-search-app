//
//  GitRepositoryDetailView.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/24
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

final class GitRepositoryDetailView: UIView {
    private typealias ElementID = GitRepositoryDetailViewElementID
    
    // MARK: UI
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = ElementID.imageView
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .trailing
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        label.accessibilityIdentifier = ElementID.titleLabel
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.accessibilityIdentifier = ElementID.languageLabel
        return label
    }()
    
    let starsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.accessibilityIdentifier = ElementID.starsLabel
        return label
    }()
    
    let watchesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.accessibilityIdentifier = ElementID.watchesLabel
        return label
    }()
    
    let forksLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.accessibilityIdentifier = ElementID.forksLabel
        return label
    }()
    
    let issuesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.accessibilityIdentifier = ElementID.issuesLabel
        return label
    }()
    
    // MARK: レイアウト制約
    private var commonConstraints: [NSLayoutConstraint] = []
    private var wideConstraints: [NSLayoutConstraint] = []
    
    // MARK: メソッド
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(languageLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(starsLabel)
        stackView.addArrangedSubview(watchesLabel)
        stackView.addArrangedSubview(forksLabel)
        stackView.addArrangedSubview(issuesLabel)
        
        let safeArea = safeAreaLayoutGuide
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: 縦長のレイアウト
        commonConstraints = [
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
            imageView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.9),
            imageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            
            languageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            languageLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: languageLabel.trailingAnchor),
            stackView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ]
        
        // MARK: 横長のレイアウト
        wideConstraints = [
            imageView.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.9),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            imageView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -5),

            languageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            languageLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: languageLabel.trailingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 画面サイズに応じて、適切なオートレイアウト制約を有効化する。
    func activateLayoutConstraints(frameSize size: CGSize) {
        if size.width > size.height {
            NSLayoutConstraint.deactivate(commonConstraints)
            NSLayoutConstraint.activate(wideConstraints)
        } else {
            NSLayoutConstraint.deactivate(wideConstraints)
            NSLayoutConstraint.activate(commonConstraints)
        }
    }
}

#Preview("UIKit") {
    let vc = GitRepositoryDetailViewController(
        gitRepository: GitRepository(
            id: 0,
            fullName: "sample/repository",
            htmlURL: "https://example.com",
            owner: GitRepositoryOwner(
                id: 100,
                login: "sample",
                avatarURL: "https://avatars.githubusercontent.com/u/9919?s=200&v=4"
            ),
            language: "Java",
            stargazersCount: 314,
            watchersCount: 15,
            forksCount: 92,
            openIssuesCount: 65
        ),
        imageFetcher: ImageFetcher()
    )
    return UINavigationController(rootViewController: vc)
}
