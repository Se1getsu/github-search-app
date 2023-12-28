//
//  SearchSettingPopoverView.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/28
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

final class SearchSettingPopoverView: UIView {
    typealias ElementID = SearchSettingPopoverViewElementID
    
    // MARK: UI
    let sortOrderLabel: UILabel = {
        let label = UILabel()
        label.text = "並び順"
        label.textColor = .label
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    let sortOrderTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.accessibilityIdentifier = ElementID.tableView
        tableView.backgroundColor = .clear
        tableView.rowHeight = 38
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    // MARK: メソッド
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppColor.background
        
        addSubview(sortOrderLabel)
        addSubview(sortOrderTableView)
        
        let safeArea = safeAreaLayoutGuide
        sortOrderLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sortOrderLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            sortOrderLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            sortOrderLabel.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -18),
            sortOrderLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
        
        sortOrderTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sortOrderTableView.topAnchor.constraint(equalTo: sortOrderLabel.bottomAnchor),
            sortOrderTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            sortOrderTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            sortOrderTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
