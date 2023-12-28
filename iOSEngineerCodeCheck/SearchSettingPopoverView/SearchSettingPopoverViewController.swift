//
//  SearchSettingPopoverViewController.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/28
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchSettingPopoverViewController: UIViewController {
    // MARK: 依存
    private let myView = SearchSettingPopoverView()
    
    // MARK: 定数
    private let sortOptions: [GitRepositorySortOption] = [.bestMatch, .stars, .forks, .updated]
    
    // MARK: 状態
    private var selectedSortOprion: GitRepositorySortOption = .bestMatch
    
    // MARK: メソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = CGSize(width: 210, height: 175)
        view = myView
        
        myView.sortOrderTableView.dataSource = self
    }
}

extension SearchSettingPopoverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let sortOption = sortOptions[indexPath.row]
        if sortOption == selectedSortOprion {
            cell.accessoryType = .checkmark
        }
        cell.tintColor = AppColor.base
        var content = cell.defaultContentConfiguration()
        content.text = sortOption.description
        cell.contentConfiguration = content
        return cell
    }
}
