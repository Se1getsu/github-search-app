//
//  NSLayoutConstraint.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/29
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    /// 制約の優先度を `.defaultHigh` に設定し、自分自身を返す。
    func withSecondaryPriority() -> Self {
        self.priority = .defaultHigh
        return self
    }
}
