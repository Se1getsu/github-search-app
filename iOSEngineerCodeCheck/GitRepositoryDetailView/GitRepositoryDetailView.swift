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
    let backgroundView: UIView = {
        let myView = UIView()
        myView.backgroundColor = AppColor.background
        return myView
    }()
    
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
    
    let titleScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.label
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        label.accessibilityIdentifier = ElementID.titleLabel
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.accessibilityIdentifier = ElementID.languageLabel
        return label
    }()
    
    let starsLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.accessibilityIdentifier = ElementID.starsLabel
        return label
    }()
    
    let watchesLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.accessibilityIdentifier = ElementID.watchesLabel
        return label
    }()
    
    let forksLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.label
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.accessibilityIdentifier = ElementID.forksLabel
        return label
    }()
    
    let issuesLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.label
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
        
        addSubview(backgroundView)
        addSubview(imageView)
        addSubview(titleScrollView)
        titleScrollView.addSubview(titleLabel)
        addSubview(languageLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(starsLabel)
        stackView.addArrangedSubview(watchesLabel)
        stackView.addArrangedSubview(forksLabel)
        stackView.addArrangedSubview(issuesLabel)
        
        // MARK: 共通のレイアウト
        let safeArea = safeAreaLayoutGuide
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        let titleScrollContent = titleScrollView.contentLayoutGuide
        let titleScrollFrame = titleScrollView.frameLayoutGuide
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleScrollContent.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: titleScrollContent.centerXAnchor),
            titleLabel.widthAnchor.constraint(equalTo: titleScrollContent.widthAnchor),
            titleLabel.widthAnchor.constraint(greaterThanOrEqualTo: titleScrollFrame.widthAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleScrollContent.bottomAnchor)
        ])
        
        // MARK: 縦長のレイアウト
        imageView.translatesAutoresizingMaskIntoConstraints = false
        titleScrollView.translatesAutoresizingMaskIntoConstraints = false
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        commonConstraints = [
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0),
            imageView.widthAnchor.constraint(lessThanOrEqualTo: safeArea.widthAnchor, multiplier: 0.9),
            imageView.widthAnchor.constraint(lessThanOrEqualTo: safeArea.heightAnchor, multiplier: 0.6),
            imageView.widthAnchor.constraint(greaterThanOrEqualTo: safeArea.widthAnchor, multiplier: 0.9)
                .withSecondaryPriority(),
            imageView.widthAnchor.constraint(greaterThanOrEqualTo: safeArea.heightAnchor, multiplier: 0.6)
                .withSecondaryPriority(),
            
            titleScrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleScrollView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            titleScrollView.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            titleScrollView.heightAnchor.constraint(equalToConstant: 42),
            
            languageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            languageLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: languageLabel.trailingAnchor),
            stackView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor)
        ]
        
        // MARK: 横長のレイアウト
        wideConstraints = [
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            imageView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0),
            imageView.heightAnchor.constraint(lessThanOrEqualTo: safeArea.heightAnchor, multiplier: 0.9),
            imageView.heightAnchor.constraint(lessThanOrEqualTo: safeArea.widthAnchor, multiplier: 0.5),
            imageView.heightAnchor.constraint(greaterThanOrEqualTo: safeArea.heightAnchor, multiplier: 0.9)
                .withSecondaryPriority(),
            imageView.heightAnchor.constraint(greaterThanOrEqualTo: safeArea.widthAnchor, multiplier: 0.5)
                .withSecondaryPriority(),
            
            titleScrollView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 10),
            titleScrollView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20),
            titleScrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            titleScrollView.heightAnchor.constraint(equalToConstant: 42),
            
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
