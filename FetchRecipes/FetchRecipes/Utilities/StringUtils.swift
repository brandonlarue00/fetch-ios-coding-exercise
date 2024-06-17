//
//  StringUtils.swift
//  FetchRecipes
//
//  Created by Brandon LaRue on 6/17/24.
//

import Foundation

func capitalizeFirstLetters(of text: String) -> String {
    return text.components(separatedBy: " ").map { $0.capitalized }.joined(separator: " ")
}
