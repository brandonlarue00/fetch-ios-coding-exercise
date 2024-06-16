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
                    self.meals = self.processRecipes(meals)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
    
    private func processRecipes(_ meals: [Meal]) -> [Meal] {
        var cleanedRecipes = removeNullOrEmptyValues(from: meals)
        cleanedRecipes = removeDuplicates(from: cleanedRecipes)
        return sortMealsAlphabetically(cleanedRecipes)
    }
    
    private func removeNullOrEmptyValues(from meals: [Meal]) -> [Meal] {
        return meals.filter { meal in
            guard let name = meal.name, !name.isEmpty else { return false }
            guard let thumbnailURL = meal.thumbnailURL, !thumbnailURL.isEmpty else { return false }
            return true
        }
    }
    
    private func removeDuplicates(from meals: [Meal]) -> [Meal] {
        let seenIds = Set<String>()
        return meals.filter { meal in
            guard !seenIds.contains(meal.id) else { return false }
            return true
        }
    }
    
    private func sortMealsAlphabetically(_ meals: [Meal]) -> [Meal] {
        return meals.sorted { ($0.name ?? "") < ($1.name ?? "") }
    }
}
