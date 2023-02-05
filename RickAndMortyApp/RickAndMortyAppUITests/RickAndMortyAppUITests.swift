//
//  RickAndMortyAppUITests.swift
//  RickAndMortyAppUITests
//
//  Created by Alberto Penas Amor on 27/1/23.
//

import XCTest

final class RickAndMortyAppUITests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
    }

    func testLoading() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.activityIndicators["characters_loading"].exists)
        XCTAssertEqual(app.activityIndicators["characters_loading"].staticTexts.firstMatch.title, "")
    }
    
    func testSuccess() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(app.staticTexts["character_1_name"].exists)
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
