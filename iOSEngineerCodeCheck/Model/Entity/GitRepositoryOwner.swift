//
//  GitRepositoryOwner.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/24
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Foundation

/// Git リポジトリの所有者となる個人または組織の情報。
struct GitRepositoryOwner: Decodable {
    let id: Int
    
    /// アカウント名 または 組織名。
    let login: String
    
    /// アイコン画像のURL。
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarURL = "avatar_url"
    }
}
