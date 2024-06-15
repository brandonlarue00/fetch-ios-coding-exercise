//
//  APIService.swift
//  FetchRecipes
//
//  Created by Brandon LaRue on 6/14/24.
//

import Foundation

class APIService {
    // Singleton instance of the API Service
    static let shared = APIService()
    
    // Function to fetch recipes
    func fetchRecipes() {
        // Check if URL is valid then assign to a constant
        guard let url = URL(string: Constants.dessertCategoryURL) else {
            print("Error: Invalid URL")
            return
        }
        
        // Create a data task to perform the network request
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            // Check for error with request
            guard let data = data else {
                print("Error: No data returned from the server")
                return
            }
            // Ensure there is data returned
            if let jsonString = String(data: data, encoding: .utf8) {
                print("ResponseJSON: \(jsonString)")
            } else {
                print("Error: Unable to convert data to string")
            }
        }.resume() // Start task
    }
}
