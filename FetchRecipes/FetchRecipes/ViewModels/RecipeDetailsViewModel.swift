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
                    self.recipeDetails = recipeDetails
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
