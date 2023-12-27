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
    static let base = UIColor.systemPurple
    static let background = base.withAlphaComponent(0.1)
    static let navigationBar = base.withAlphaComponent(0.4)
    static let searchBarBarTint = UIColor.systemGray6
}
