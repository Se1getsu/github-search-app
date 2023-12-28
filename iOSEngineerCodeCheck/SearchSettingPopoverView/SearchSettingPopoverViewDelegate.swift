//
//  SearchSettingPopoverViewDelegate.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/28
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

/// `SearchSettingPopoverView` の設定アクションの通知を受け取り、設定内容を更新する。
protocol SearchSettingPopoverViewDelegate: AnyObject {
    /// 現在設定されているソートオプション。
    var currentSortOption: GitRepositorySortOption { get }
    
    /// ソートオプションが選択された。
    func didSelectSortOption(_ sortOption: GitRepositorySortOption)
}
