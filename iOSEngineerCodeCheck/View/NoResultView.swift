//
//  NoResultView.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/25
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

final class NoResultView: UIView {
    // MARK: UI
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .systemGray
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "検索結果なし"
        label.textColor = .label
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    // MARK: メソッド
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        addSubview(imageView)
        addSubview(label)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor, constant: -30),
            imageView.widthAnchor.constraint(equalToConstant: 80),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0)
        ])
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
