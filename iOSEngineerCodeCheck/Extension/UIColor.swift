//
//  UIColor.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/29
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import UIKit

extension UIColor {
    /// 通常モード/ハイコントラストモードの色を受け取って UIColor を生成する。
    public class func dynamic(normal: UIColor, highContrast: UIColor) -> UIColor {
        return UIColor { trait in
            if trait.accessibilityContrast == .high {
                highContrast
            } else {
                normal
            }
        }
    }
}
