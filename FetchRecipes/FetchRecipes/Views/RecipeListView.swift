//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Brandon LaRue on 6/14/24.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel()
    @State private var selectedRecipeId: String?
    
    var body: some View {
        NavigationStack {
            VStack {
                if let errorMessage = viewModel.errorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundStyle(Color.red)
                }
                
                List(viewModel.meals) { meal in
                    ZStack {
                        RecipeView(meal: meal)
                        NavigationLink(
                            value: meal.id,
                            label: { EmptyView() }
                        )
                        .opacity(0)
                    }
                }
                .onAppear(perform: viewModel.fetchRecipes)
                .navigationDestination(for: String.self) { mealId in
                    RecipeDetailsView(mealId: mealId)
                }
            }
            // .navigationTitle("Recipes")
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
