//
//  Constants.swift
//  FetchRecipes
//
//  Created by Brandon LaRue on 6/14/24.
//

import Foundation

struct Constants {
    // Base URL for all endpoints in this project
    static let baseURL = "https://themealdb.com/api/json/v1/1"
    
    // Endpoint URLs
    static let dessertCategoryURL = "\(baseURL)/filter.php?c=Dessert"
    static let recipeDetailURL = "\(baseURL)/lookup.php?i="
}
