//
//  GitRepositoryDetailView.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/24
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

final class GitRepositoryDetailView: UIView {
    // MARK: UI
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
        return label
    }()
    
    let languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    let starsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    let watchesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    let forksLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    let issuesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    // MARK: メソッド
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(languageLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(starsLabel)
        stackView.addArrangedSubview(watchesLabel)
        stackView.addArrangedSubview(forksLabel)
        stackView.addArrangedSubview(issuesLabel)
        
        // TODO: 横画面にすると画像が大きくなりすぎる。
        let safeArea = safeAreaLayoutGuide
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 5),
            imageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20)
        ])
        
        languageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            languageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            languageLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: languageLabel.trailingAnchor),
            stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        )
    )
    return UINavigationController(rootViewController: vc)
}
