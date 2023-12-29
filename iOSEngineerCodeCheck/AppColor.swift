//
//  AppColor.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/27
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

/// アプリのUIに使用する UIColor をまとめたもの。
enum AppColor {
    // MARK: ベースの色
    static let base = UIColor.systemPurple
    
    // MARK: ナビゲーションバー
    static let navigationBar = base.withAlphaComponent(0.3)
    static let navigationBarTint = UIColor.dynamic(
        normal: AppColor.base,
        highContrast: .systemRed
    )
    static let navigationBarTitle = UIColor.label
    
    // MARK: 背景
    static let background = base.withAlphaComponent(0.1)
    
    // MARK: ラベル
    static let label = UIColor.label
    static let secondaryLabel = UIColor.secondaryLabel
    
    // MARK: サーチバー
    static let searchBarBarTint = UIColor.systemGray6
    
    // MARK: アイコン
    static let secondarySystemIcon = UIColor.systemGray
}
