//
//  GitRepositoryDetailViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class GitRepositoryDetailViewController: UIViewController {
    // MARK: UI
    private let imageView: UIImageView = {
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
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    private let starsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    private let watchesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    private let forksLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    private let issuesLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "[full_name]"
        view.backgroundColor = .white
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(languageLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(starsLabel)
        stackView.addArrangedSubview(watchesLabel)
        stackView.addArrangedSubview(forksLabel)
        stackView.addArrangedSubview(issuesLabel)
        
        // TODO: 横画面にすると画像が大きくなりすぎる。
        let safeArea = view.safeAreaLayoutGuide
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
        
        languageLabel.text = "Written in [language]"
        starsLabel.text = "[stargazers_count] stars"
        watchesLabel.text = "[wachers_count] watchers"
        forksLabel.text = "[forks_count] forks"
        issuesLabel.text = "[open_issues_count] open issues"
        getImage()
    }
    
    func getImage() {
        titleLabel.text = "[full_name]"
        Task {
            // TODO: 所有者の画像のURLを指定
            let url = URL(string: "https://avatars.githubusercontent.com/u/10639145?v=4")!
            let image = try await ImageFetcher().fetchImage(from: url)
            await MainActor.run {
                imageView.image = image
            }
        }
    }
}
