//
//  ImageFetcher.swift
//  iOSEngineerCodeCheck
//  
//  Created by Seigetsu on 2023/12/24
//  Copyright © 2023 YUMEMI Inc. All rights reserved.
//

import Alamofire
import UIKit.UIImage

/// 画像のフェッチを行う。
struct ImageFetcher {
    /// 画像をフェッチする。
    func fetchImage(from url: URL) async throws -> UIImage? {
        let response = await AF.request(url).serializingData().response
        
        switch response.result {
        case .success(let data):
            return UIImage(data: data)
            
        case .failure(let error):
            throw error
        }
    }
}
