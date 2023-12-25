//
//  GitRepositoryListPresenterOutput.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/24
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GitRepositoryListPresenterOutput: AnyObject {
    /// 画面に表示している Git リポジトリの情報を更新する。
    func reloadGitRepositories()
    
    /// アラートを表示する。ユーザには [再試行] および [キャンセル] の選択肢を与える。
    func showRetryOrCancelAlert(title: String, message: String?)
}
