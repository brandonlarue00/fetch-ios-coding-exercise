//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Brandon LaRue on 6/14/24.
//

import SwiftUI

struct RecipeListView: View {
    // @State private var meals: [Meal] = []
    // @State private var errorMessage: String?
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
        }
    }
    
    /*
    private func fetchRecipes() {
        APIService.shared.fetchRecipes { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let meals):
                    self.meals = meals
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
     */
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
