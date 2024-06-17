//
//  RecipeListViewModelTests.swift
//  FetchRecipesTests
//
//  Created by Brandon LaRue on 6/17/24.
//

@testable import FetchRecipes
import XCTest

final class RecipeListViewModelTests: XCTestCase {
    var viewModel: RecipeListViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = RecipeListViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }

    func testProcessRecipes() {
        let meals = [
            Meal(id: "1", name: "Apple Pie", thumbnailURL: "URL1"),
            Meal(id: "2", name: "Banana Split", thumbnailURL: "URL2"),
            Meal(id: "3", name: "", thumbnailURL: "URL3"),
            Meal(id: "4", name: "Cherry Tart", thumbnailURL: "")
        ]
        let processedMeals = viewModel.processRecipes(meals)
        XCTAssertEqual(processedMeals.count, 2)
        XCTAssertEqual(processedMeals[0].name, "Apple Pie")
        XCTAssertEqual(processedMeals[1].name, "Banana Split")
    }

    func testRemoveNullOrEmptyValues() throws {
        let meals = [
            Meal(id: "1", name: "Meal 1", thumbnailURL: "http://example.com/meal1.jpg"),
            Meal(id: "2", name: "", thumbnailURL: "http://example.com/meal2.jpg"),
            Meal(id: "3", name: "Meal 3", thumbnailURL: nil),
            Meal(id: "4", name: nil, thumbnailURL: "http://example.com/meal4.jpg"),
            Meal(id: "5", name: "Meal 5", thumbnailURL: "http://example.com/meal5.jpg")
        ]

        let filteredMeals = viewModel.removeNullOrEmptyValues(from: meals)

        XCTAssertEqual(filteredMeals.count, 2)
        XCTAssertTrue(filteredMeals.contains { $0.id == "1" })
        XCTAssertTrue(filteredMeals.contains { $0.id == "5" })
    }

    func testRemoveDuplicates() throws {
        let meals = [
            Meal(id: "1", name: "Meal 1", thumbnailURL: "http://example.com/meal1.jpg"),
            Meal(id: "2", name: "Meal 2", thumbnailURL: "http://example.com/meal2.jpg"),
            Meal(id: "1", name: "Meal 1", thumbnailURL: "http://example.com/meal1.jpg"),
            Meal(id: "3", name: "Meal 3", thumbnailURL: "http://example.com/meal3.jpg")
        ]

        let uniqueMeals = viewModel.removeDuplicates(from: meals)

        XCTAssertEqual(uniqueMeals.count, 3)
        XCTAssertTrue(uniqueMeals.contains { $0.id == "1" })
        XCTAssertTrue(uniqueMeals.contains { $0.id == "2" })
        XCTAssertTrue(uniqueMeals.contains { $0.id == "3" })
    }

    func testSortMealsAlphabetically() {
        let meals = [
            Meal(id: "1", name: "Apple Pie", thumbnailURL: "URL1"),
            Meal(id: "2", name: "banana split", thumbnailURL: "URL2"),
            Meal(id: "3", name: "Cherry Tart", thumbnailURL: "URL3"),
            Meal(id: "4", name: "Christmas cake", thumbnailURL: "URL4"),
            Meal(id: "5", name: "Christmas Pudding Trifle", thumbnailURL: "URL5")
        ]

        let sortedMeals = viewModel.sortMealsAlphabetically(meals)
        XCTAssertEqual(sortedMeals[0].name, "Apple Pie")
        XCTAssertEqual(sortedMeals[1].name, "banana split")
        XCTAssertEqual(sortedMeals[2].name, "Cherry Tart")
        XCTAssertEqual(sortedMeals[3].name, "Christmas cake")
        XCTAssertEqual(sortedMeals[4].name, "Christmas Pudding Trifle")
    }

    func testCapitalizeMealNames() {
        let meals = [
            Meal(id: "1", name: "apple pie", thumbnailURL: "URL1"),
            Meal(id: "2", name: "banana split", thumbnailURL: "URL2"),
            Meal(id: "3", name: "cherry tart", thumbnailURL: "URL3")
        ]
        let capitalizedMeals = viewModel.capitalizeMealNames(meals)
        XCTAssertEqual(capitalizedMeals[0].name, "Apple Pie")
        XCTAssertEqual(capitalizedMeals[1].name, "Banana Split")
        XCTAssertEqual(capitalizedMeals[2].name, "Cherry Tart")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
