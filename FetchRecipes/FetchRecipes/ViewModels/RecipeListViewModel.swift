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
    
    private let apiService: APIServiceProtocol
    
    init(apiService: APIServiceProtocol = APIService.shared) {
        self.apiService = apiService
    }
    
    @MainActor
    func fetchRecipes() async {
        do {
            let recipes = try await apiService.fetchRecipes()
            self.meals = self.processRecipes(recipes)
        } catch {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func processRecipes(_ meals: [Meal]) -> [Meal] {
        var cleanedRecipes = removeNullOrEmptyValues(from: meals)
        cleanedRecipes = removeDuplicates(from: cleanedRecipes)
        cleanedRecipes = capitalizeMealNames(cleanedRecipes)
        return sortMealsAlphabetically(cleanedRecipes)
    }
    
    func removeNullOrEmptyValues(from meals: [Meal]) -> [Meal] {
        return meals.filter { meal in
            guard let name = meal.name, !name.isEmpty else { return false }
            guard let thumbnailURL = meal.thumbnailURL, !thumbnailURL.isEmpty else { return false }
            return true
        }
    }
    
    func removeDuplicates(from meals: [Meal]) -> [Meal] {
        var seenIds = Set<String>()
        return meals.filter { meal in
            guard !seenIds.contains(meal.id) else { return false }
            seenIds.insert(meal.id)
            return true
        }
    }
    
    func capitalizeMealNames(_ meals: [Meal]) -> [Meal] {
        return meals.map { meal in
            var capitalizedMeal = meal
            capitalizedMeal.name = capitalizeFirstLetters(of: meal.name ?? "")
            return capitalizedMeal
        }
    }
    
    func sortMealsAlphabetically(_ meals: [Meal]) -> [Meal] {
        return meals.sorted {
            ($0.name ?? "").localizedCaseInsensitiveCompare($1.name ?? "") == .orderedAscending
        }
    }
}
