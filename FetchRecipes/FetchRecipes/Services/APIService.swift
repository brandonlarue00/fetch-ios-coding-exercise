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
    func fetchRecipes(completion: @escaping (Result<[Meal], Error>) -> Void) {
        guard let url = URL(string: Constants.dessertCategoryURL) else {
            print("Error: Invalid URL")
            completion(.failure(NSError(domain: "URL Error", code: -1)))
            return
        }

        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Error: Invalid Response")
                completion(.failure(NSError(domain: "Invalid Response", code: -1)))
                return
            }
            
            print("HTTP Status Code: \(httpResponse.statusCode)")
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Error: HTTP status code \(httpResponse.statusCode)")
                completion(.failure(NSError(domain: "HTTP Error", code: httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                print("Error: No data returned from the server")
                completion(.failure(NSError(domain: "Data Error", code: -1)))
                return
            }
            // Ensure there is data returned
            /*
             if let jsonString = String(data: data, encoding: .utf8) {
                 print("ResponseJSON: \(jsonString)")
             } else {
                 print("Error: Unable to convert data to string")
             }
              */
            do {
                let mealResponse = try JSONDecoder().decode([String: [Meal]].self, from: data)

                if let meals = mealResponse["meals"] {
                    // print("Fetched Meals: \(meals)")
                    completion(.success(meals))
                } else {
                    print("Error: Parsing meals failed")
                    completion(.failure(NSError(domain: "Parsing Error", code: -1)))
                }
            } catch {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume() // Start task
    }
    
    func fetchRecipeDetails(for id: String) {
        let urlString = Constants.recipeDetailURL + id
        // print("URL String: \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Error: Invalid URL")
            return
        }
        
        let urlRequest = URLRequest(url: url)
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpRespoonse = response as? HTTPURLResponse else {
                print("Error: Invalid Response")
                return
            }
            
            print("HTTP Status code: \(httpRespoonse.statusCode)")
            
            guard (200...299).contains(httpRespoonse.statusCode) else {
                print("Error: HTTP status code \(httpRespoonse.statusCode)")
                return
            }
            
            guard let data = data else {
                print("Error: No data returned")
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                print("Fetched Recipe Details: \(jsonResponse)")
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }.resume()
    }
}
