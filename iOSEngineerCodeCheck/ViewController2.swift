//
//  ViewController2.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ViewController2: UIViewController {
    // MARK: UI
    @IBOutlet weak var ImgView: UIImageView!
    @IBOutlet weak var TtlLbl: UILabel!
    @IBOutlet weak var LangLbl: UILabel!
    @IBOutlet weak var StrsLbl: UILabel!
    @IBOutlet weak var WchsLbl: UILabel!
    @IBOutlet weak var FrksLbl: UILabel!
    @IBOutlet weak var IsssLbl: UILabel!
    
    var vc1: ViewController!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LangLbl.text = "Written in [language]"
        StrsLbl.text = "[stargazers_count] stars"
        WchsLbl.text = "[wachers_count] watchers"
        FrksLbl.text = "[forks_count] forks"
        IsssLbl.text = "[open_issues_count] open issues"
        getImage()
    }
    
    func getImage() {
        TtlLbl.text = "[full_name]"
        Task {
            // TODO: 所有者の画像のURLを指定
            let url = URL(string: "https://avatars.githubusercontent.com/u/10639145?v=4")!
            let image = try await ImageFetcher().fetchImage(from: url)
            await MainActor.run {
                ImgView.image = image
            }
        }
    }
}
