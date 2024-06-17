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
        let processedIngredients = recipeDetails.ingredients.compactMap { $0 }.filter { !$0.isEmpty }
        let processedMeasures = recipeDetails.measures.compactMap { $0 }.filter { !$0.isEmpty }

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
}
