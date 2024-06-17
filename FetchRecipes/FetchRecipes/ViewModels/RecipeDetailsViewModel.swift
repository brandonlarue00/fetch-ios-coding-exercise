//
//  RecipeDetailsViewModel.swift
//  FetchRecipes
//
//  Created by Brandon LaRue on 6/17/24.
//

import Foundation

class RecipeDetailsViewModel: ObservableObject {
    @Published var recipeDetails: RecipeDetails?
    @Published var errorMessage: String?

    func fetchRecipeDetails(for id: String) {
        APIService.shared.fetchRecipeDetails(for: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipeDetails):
                    self.recipeDetails = self.processRecipeDetails(recipeDetails)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func processRecipeDetails(_ recipeDetails: RecipeDetails) -> RecipeDetails {
        var processedIngredients = recipeDetails.ingredients.compactMap { $0 }.filter { !$0.isEmpty }.map { capitalizeFirstLetters(of: $0) }
        var processedMeasures = recipeDetails.measures.compactMap { $0 }.filter { !$0.isEmpty }
        
        (processedIngredients, processedMeasures) = removeDuplicates(ingredients: processedIngredients, measures: processedMeasures)

        return RecipeDetails(
            id: recipeDetails.id,
            name: recipeDetails.name,
            instructions: recipeDetails.instructions,
            thumbnailURL: recipeDetails.thumbnailURL,
            area: recipeDetails.area,
            category: recipeDetails.category,
            source: recipeDetails.source,
            youtube: recipeDetails.youtube,
            ingredients: processedIngredients,
            measures: processedMeasures
        )
    }

    func capitalizeFirstLetters(of text: String) -> String {
        return text.components(separatedBy: " ").map { $0.capitalized }.joined(separator: " ")
    }

    func separateInstructions(_ instructions: String) -> [String] {
        return instructions.components(separatedBy: .newlines).filter { !$0.isEmpty }
    }

    func removeDuplicates(ingredients: [String], measures: [String]) -> ([String], [String]) {
        var uniqueIngredients = [String]()
        var uniqueMeasures = [String]()

        for (index, ingredient) in ingredients.enumerated() {
            if !uniqueIngredients.contains(ingredient) {
                uniqueIngredients.append(ingredient)
                uniqueMeasures.append(measures[safe: index] ?? "")
            }
        }

        return (uniqueIngredients, uniqueMeasures)
    }
}
