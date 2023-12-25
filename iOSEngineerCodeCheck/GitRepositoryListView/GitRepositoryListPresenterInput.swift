//
//  GitRepositoryListPresenterInput.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/24
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GitRepositoryListPresenterInput {
    /// 画面に表示するための Git リポジトリの配列。
    var gitRepositories: [GitRepository] { get }
    
    /// サーチバーのテキストに変更が加えられた時の処理。
    func searchBar(textDidChange searchText: String)
    
    /// サーチバーから検索が実行される処理。
    func searchBarSearchButtonClicked(searchText: String)
    
    /// アラートの [再試行] オプションが選択された時の処理。
    func alertRetrySelected()
    
    /// アラートの [キャンセル] オプションが選択された時の処理。
    func alertCancelSelected()
}
