//
//  iOSEngineerCodeCheckUITests.swift
//  iOSEngineerCodeCheckUITests
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import XCTest

class iOSEngineerCodeCheckUITests: XCTestCase {
    private let networkTimeoutInterval: UInt32 = 3
    private let screenTransitionInterval: UInt32 = 1
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func test_リポジトリ検索_詳細表示() throws {
        let app = XCUIApplication()
        app.launch()
        
        let guidanceLabel = app.staticTexts["Search Guidance Label"].firstMatch
        XCTAssertTrue(guidanceLabel.exists)
        XCTAssertTrue(guidanceLabel.isHittable)
        
        let searchBar = app.otherElements["Git Repository Search Bar"].firstMatch
        XCTAssertTrue(searchBar.exists)
        XCTAssertTrue(searchBar.isHittable)
        
        // MARK: 「swift」を検索
        searchBar.tap()
        searchBar.typeText("swift\n")
        sleep(networkTimeoutInterval)
        
        let tableView = app.tables["Git Repository List Table"].firstMatch
        XCTAssertTrue(tableView.exists)
        XCTAssertTrue(tableView.isHittable)
        XCTAssertGreaterThanOrEqual(tableView.cells.count, 1)
        
        // MARK: 1番上のセルをタップ
        tableView.cells.element(boundBy: 0).tap()
        sleep(screenTransitionInterval)
        
        let imageView = app.images["Git Repository Image View"].firstMatch
        XCTAssertTrue(imageView.exists)
        XCTAssertTrue(imageView.isHittable)
        
        for elementID in [
            "Git Repository Title Label",
            "Git Repository Language Label",
            "Git Repository Stars Label",
            "Git Repository Watches Label",
            "Git Repository Forks Label",
            "Git Repository Issues Label"
        ] {
            let label = app.staticTexts[elementID].firstMatch
            XCTAssertTrue(label.exists)
            XCTAssertTrue(label.isHittable)
        }
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
