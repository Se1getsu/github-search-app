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
    
    // MARK: デリゲート
    weak var delegate: SearchSettingPopoverViewDelegate?
    
    // MARK: 定数
    private let sortOptions: [GitRepositorySortOption] = [.bestMatch, .stars, .forks, .updated]
    
    // MARK: メソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        preferredContentSize = CGSize(width: 210, height: 175)
        view = myView
        
        myView.sortOrderTableView.dataSource = self
        myView.sortOrderTableView.delegate = self
    }
}

extension SearchSettingPopoverViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let sortOption = sortOptions[indexPath.row]
        cell.accessoryType = sortOption == delegate?.currentSortOption ? .checkmark : .none
        cell.tintColor = AppColor.base
        var content = cell.defaultContentConfiguration()
        content.text = sortOption.description
        cell.contentConfiguration = content
        return cell
    }
}

extension SearchSettingPopoverViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedSortOption = sortOptions[indexPath.row]
        delegate?.didSelectSortOption(selectedSortOption)
        tableView.reloadData()
    }
}
