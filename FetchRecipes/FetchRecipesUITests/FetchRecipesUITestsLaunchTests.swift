//
//  FetchRecipesUITestsLaunchTests.swift
//  FetchRecipesUITests
//
//  Created by Brandon LaRue on 6/14/24.
//

import XCTest

final class FetchRecipesUITestsLaunchTests: XCTestCase {
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        let exists = NSPredicate(format: "exists == true")
        let mainView = app.collectionViews["mainView"]
        
        expectation(for: exists, evaluatedWith: mainView, handler: nil)
        
        waitForExpectations(timeout: 10, handler: nil)

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
