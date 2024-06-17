//
//  APIService.swift
//  FetchRecipes
//
//  Created by Brandon LaRue on 6/14/24.
//

import Foundation

protocol APIServiceProtocol {
    // func fetchRecipes(completion: @escaping (Result<[Meal], Error>) -> Void)
    func fetchRecipes() async throws -> [Meal]
    // func fetchRecipeDetails(for id: String, completion: @escaping (Result<RecipeDetails, Error>) -> Void)
    func fetchRecipeDetails(for id: String) async throws -> RecipeDetails
}

class APIService: APIServiceProtocol {
    // Singleton instance of the API Service
    static let shared = APIService()

    // Function to fetch recipes
    /*
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
     */
    
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
    
    /*
    func fetchRecipeDetails(for id: String, completion: @escaping (Result<RecipeDetails, Error>) -> Void) {
        let urlString = Constants.recipeDetailURL + id
        // print("URL String: \(urlString)")
        
        guard let url = URL(string: urlString) else {
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
            
            guard let httpRespoonse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid Response", code: -1)))
                print("Error: Invalid Response")
                return
            }
            
            print("HTTP Status code: \(httpRespoonse.statusCode)")
            
            guard (200...299).contains(httpRespoonse.statusCode) else {
                print("Error: HTTP status code \(httpRespoonse.statusCode)")
                completion(.failure(NSError(domain: "HTTP Error", code: -1)))
                return
            }
            
            guard let data = data else {
                print("Error: No data returned")
                completion(.failure(NSError(domain: "Data Error", code: -1)))
                return
            }
            
            do {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON Response: \(jsonString)")
                }
                
                let recipeDetailResponse = try JSONDecoder().decode([String: [RecipeDetails]].self, from: data)
                if let recipeDetails = recipeDetailResponse["meals"]?.first {
                    print("Recipe Details: \(recipeDetails)")
                    completion(.success(recipeDetails))
                } else {
                    print("Error: Parsing meal details failed")
                    completion(.failure(NSError(domain: "Parsing Error", code: -1)))
                }
            } catch {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
     */
    
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
