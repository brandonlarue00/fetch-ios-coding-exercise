//
//  APIService.swift
//  FetchRecipes
//
//  Created by Brandon LaRue on 6/14/24.
//

import Foundation

protocol APIServiceProtocol {
    func fetchRecipes() async throws -> [Meal]
    func fetchRecipeDetails(for id: String) async throws -> RecipeDetails
}

class APIService: APIServiceProtocol {
    static let shared = APIService()
    
    var urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func fetchRecipes() async throws -> [Meal] {
        guard let url = URL(string: Constants.dessertCategoryURL) else {
            throw NSError(domain: "URL Error", code: -1)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "HTTP Error", code: -1)
        }
        
        let recipeResponse = try JSONDecoder().decode([String: [Meal]].self, from: data)
        
        if let recipes = recipeResponse["meals"] {
            return recipes
        } else {
            throw NSError(domain: "Parsing Error", code: -1)
        }
    }
    
    func fetchRecipeDetails(for id: String) async throws -> RecipeDetails {
        let urlString = Constants.recipeDetailURL + id
        
        guard let url = URL(string: urlString) else {
            throw NSError(domain: "URL Error", code: -1)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw NSError(domain: "HTTP Error", code: -1)
        }
        
        let recipeDetailResponse = try JSONDecoder().decode([String: [RecipeDetails]].self, from: data)
        
        if let recipeDetails = recipeDetailResponse["meals"]?.first {
            return recipeDetails
        } else {
            throw NSError(domain: "Parsing Error", code: -1)
        }
    }
}
