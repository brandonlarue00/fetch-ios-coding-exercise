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
                    Button(action: {
                        selectedRecipeId = meal.id
                    }) {
                        RecipeView(meal: meal)
                    }
                    .buttonStyle(.plain)
                }
                .accessibilityIdentifier("recipeList")
                .task {
                    await viewModel.fetchRecipes()
                }
                .navigationDestination(isPresented: .constant(selectedRecipeId != nil), destination: {
                    if let id = selectedRecipeId {
                        RecipeDetailsView(mealId: id)
                    }
                })
            }
            .accessibilityIdentifier("mainView")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Recipes")
                        .font(.largeTitle)
                        .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                        .padding(.top, 5)
                }
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
