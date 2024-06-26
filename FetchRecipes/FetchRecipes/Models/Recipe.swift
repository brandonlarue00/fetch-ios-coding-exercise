//
//  Recipe.swift
//  FetchRecipes
//
//  Created by Brandon LaRue on 6/14/24.
//

import Foundation

struct Meal: Identifiable, Codable, Equatable {
    let id: String
    var name: String?
    let thumbnailURL: String?

    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case name = "strMeal"
        case thumbnailURL = "strMealThumb"
    }
}
