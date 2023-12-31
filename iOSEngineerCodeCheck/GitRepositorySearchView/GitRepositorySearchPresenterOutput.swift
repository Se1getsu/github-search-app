//
//  GitRepositorySearchPresenterOutput.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/24
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GitRepositorySearchPresenterOutput: AnyObject {
    /// 画面に表示している Git リポジトリの情報を更新する。
    func reloadGitRepositories()
    
    /// アラートを表示する。ユーザには [再試行] および [キャンセル] の選択肢を与える。
    func showRetryOrCancelAlert(title: String, message: String?)
    
    /// ActivityIndicator のアニメーションを開始する。
    func startActivityIndicator()
    
    /// ActivityIndicator のアニメーションを停止する。
    func stopActivityIndicator()
    
    /// サーチバーのキーボードを閉じる。
    func searchBarEndEditing()
    
    /// サーチバーのサーチテキストを書き換える。
    func searchBarUpdateSearchText(_ searchText: String)
    
    /// 検索結果なしの表示を出す。
    func showNoResultView()
    
    /// 検索結果なしの表示を隠す。
    func hideNoResultView()
    
    /// サーチバーへの入力を促すガイダンス表示を隠す。
    func hideGuidance()
    
    /// サーチバーへの入力を促すガイダンス表示を出す。
    func showGuidance()
}
