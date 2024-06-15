//
//  RecipeListViewModel.swift
//  FetchRecipes
//
//  Created by Brandon LaRue on 6/15/24.
//

import Foundation

class RecipeListViewModel: ObservableObject {
    @Published var meals: [Meal] = []
    @Published var errorMessage: String?
    
    func fetchRecipes() {
        APIService.shared.fetchRecipes { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let meals):
                    self.meals = meals
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
