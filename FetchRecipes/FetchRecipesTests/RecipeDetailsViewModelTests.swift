//
//  RecipeDetailsViewModelTests.swift
//  FetchRecipesTests
//
//  Created by Brandon LaRue on 6/17/24.
//

import XCTest
@testable import FetchRecipes

final class RecipeDetailsViewModelTests: XCTestCase {

    var viewModel: RecipeDetailsViewModel!

    override func setUpWithError() throws {
        viewModel = RecipeDetailsViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testSeparateInstructions() {
        let instructions = "Step 1\nStep 2\nStep 3"
        let separatedInstructions = viewModel.separateInstructions(instructions)
        XCTAssertEqual(separatedInstructions, ["Step 1", "Step 2", "Step 3"])
    }

    func testRemoveDuplicates() {
        let ingredients = ["Sugar", "Flour", "Sugar"]
        let measures = ["1 cup", "2 cups", "1 cup"]
        let (uniqueIngredients, uniqueMeasures) = viewModel.removeDuplicates(ingredients: ingredients, measures: measures)
        XCTAssertEqual(uniqueIngredients, ["Sugar", "Flour"])
        XCTAssertEqual(uniqueMeasures, ["1 cup", "2 cups"])
    }
    
    func testProcessRecipeDetails() {
            let recipeDetails = RecipeDetails(
                id: "1",
                name: "meal 1",
                instructions: "Instructions",
                thumbnailURL: "URL1",
                area: "Area",
                category: "Category",
                source: "Source",
                youtube: "YouTube",
                ingredients: ["sugar", "flour", "sugar"],
                measures: ["1 cup", "2 cups", "1 cup"]
            )
            let processedDetails = viewModel.processRecipeDetails(recipeDetails)
            XCTAssertEqual(processedDetails.name, "Meal 1")
            XCTAssertEqual(processedDetails.ingredients, ["Sugar", "Flour"])
            XCTAssertEqual(processedDetails.measures, ["1 cup", "2 cups"])
        }
}
