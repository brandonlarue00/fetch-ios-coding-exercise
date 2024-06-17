//
//  FetchRecipesTests.swift
//  FetchRecipesTests
//
//  Created by Brandon LaRue on 6/14/24.
//

import XCTest
@testable import FetchRecipes

final class FetchRecipesTests: XCTestCase {
    
    var viewModel: RecipeListViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = RecipeListViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testFetchRecipes() async throws {
        let expectation = XCTestExpectation(description: "Fetch Recipes")
        
        await viewModel.fetchRecipes()
        
        XCTAssertFalse(viewModel.meals.isEmpty, "Meals should not be empty after fetching")
        expectation.fulfill()
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
    
    func testSortMealsAlphabetically() throws {
        let meals = [
                    Meal(id: "1", name: "Banana Pancakes", thumbnailURL: "http://example.com/meal1.jpg"),
                    Meal(id: "2", name: "Apple Pie", thumbnailURL: "http://example.com/meal2.jpg"),
                    Meal(id: "3", name: "Cherry Tart", thumbnailURL: "http://example.com/meal3.jpg")
                ]

        let sortedMeals = viewModel.sortMealsAlphabetically(meals)
        
        XCTAssertEqual(sortedMeals[0].name, "Apple Pie")
        XCTAssertEqual(sortedMeals[1].name, "Banana Pancakes")
        XCTAssertEqual(sortedMeals[2].name, "Cherry Tart")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
