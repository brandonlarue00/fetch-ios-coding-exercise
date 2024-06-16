//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Brandon LaRue on 6/14/24.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel()
    
    var body: some View {
        VStack {
            if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundStyle(Color.red)
            }
            
            List(viewModel.meals) { meal in
                RecipeView(meal: meal)
            }
            .onAppear(perform: viewModel.fetchRecipes)
            
            Button(action: {
                APIService.shared.fetchRecipeDetails(for: "53049") { result in
                    switch result {
                    case .success(let recipeDetails):
                        print("Fetched Recipe Details: \(recipeDetails)")
                    case .failure(let error):
                        print("Error fetching recipe details: \(error.localizedDescription)")
                    }
                }
            }, label: {
                Text("Test Recipe Details")
            })
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
