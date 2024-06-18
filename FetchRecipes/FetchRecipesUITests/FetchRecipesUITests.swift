//
//  FetchRecipesUITests.swift
//  FetchRecipesUITests
//
//  Created by Brandon LaRue on 6/14/24.
//

import XCTest

final class FetchRecipesUITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app = nil
    }

    func testRecipeListLoads() throws {
        let collectionView = app.collectionViews["recipeList"]

        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: collectionView, handler: nil)

        waitForExpectations(timeout: 15, handler: nil)
        XCTAssertTrue(collectionView.exists, "The recipe list collection view should exist.")

        let firstCell = collectionView.cells.element(boundBy: 0)

        expectation(for: exists, evaluatedWith: firstCell, handler: nil)

        waitForExpectations(timeout: 15, handler: nil)
        XCTAssertTrue(firstCell.exists, "The first cell in the recipe list should exist.")
    }

    func testRecipeDetailViewLoads() throws {
        let tableView = app.tables["recipeList"]
        let firstCell = tableView.cells.element(boundBy: 0)

        if firstCell.exists {
            firstCell.tap()

            let detailView = app.scrollViews["recipeDetailView"]
            XCTAssertTrue(detailView.exists, "The recipe detail view should exist.")

            let recipeName = detailView.staticTexts["recipeName"]
            XCTAssertTrue(recipeName.exists, "The recipe name should be displayed.")
        }
    }

    func testRecipeViewRenders() throws {
        let tableView = app.tables["recipeList"]
        let firstCell = tableView.cells.element(boundBy: 0)

        if firstCell.exists {
            let recipeName = firstCell.staticTexts.matching(identifier: "recipeName-53049").firstMatch
            XCTAssertTrue(recipeName.exists, "The recipe name should be displayed.")

            let recipeThumbnail = firstCell.images.matching(identifier: "recipeThumbnail-53049").firstMatch
            XCTAssertTrue(recipeThumbnail.exists, "The recipe thumbnail should be displayed.")
        }
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
