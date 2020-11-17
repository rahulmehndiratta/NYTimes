//
//  NYTimesUITests.swift
//  NYTimesUITests
//
//  Created by Apple on 17/11/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import XCTest

class NYTimesUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
    
    func testUiTableCellPlacedOrNot() {
        // Launch the app with an argument that tells it to reset its state
        let documentExpectation = expectation(description: "testing")
        let app = XCUIApplication()
        let tablesQuery = app.tables
        // Test UiTable Cell Placed or Not
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            let element = tablesQuery.cells.element(boundBy: 0)
            XCTAssert( element.exists)
            documentExpectation.fulfill()
        }
        app.launch()
        wait(for: [documentExpectation], timeout: 20)
    }
    
    func testActivityIndicatorHide() {
        // Launch the app with an argument that tells it to reset its state
        let app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
        
        // Check that the app is displaying an activity indicator
        let activityIndicator = app.activityIndicators.element
        XCTAssertTrue(activityIndicator.exists)
        
        // Wait for the loading indicator to disappear = content is ready
        expectation(for: NSPredicate(format: "exists == 0"),
                    evaluatedWith: activityIndicator)
                    
        // Use a generous timeout in case the network is slow
        waitForExpectations(timeout: 10)
        
    }
    
}
