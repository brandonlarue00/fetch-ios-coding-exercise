//
//  RecipeDetailsView.swift
//  FetchRecipes
//
//  Created by Brandon LaRue on 6/17/24.
//

import SwiftUI

struct RecipeDetailsView: View {
    @StateObject private var viewModel = RecipeDetailsViewModel()
    let mealId: String

    var body: some View {
        VStack {
            if let recipeDetails = viewModel.recipeDetails {
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(recipeDetails.name)
                            .font(.largeTitle)
                            .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                            .padding(.bottom, 10)

                        if let thumbnailURL = recipeDetails.thumbnailURL, let url = URL(string: thumbnailURL) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 150)
                                    .cornerRadius(8)
                            } placeholder: {
                                ProgressView()
                            }.padding(.bottom, 20)
                        }

                        Text("Ingredients")
                            .font(.headline)
                            .padding(.bottom, 5)

                        ForEach(Array(zip(recipeDetails.ingredients, recipeDetails.measures)), id: \.0) { ingredient, measure in
                            Text("\(ingredient ?? ""): \(measure ?? "")")
                                .padding(.bottom, 2)
                        }

                        Text("Instructions")
                            .font(.headline)
                            .padding(.bottom, 5)

                        Text(recipeDetails.instructions)
                    }
                }
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundStyle(Color.red)
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.fetchRecipeDetails(for: mealId)
                    }
            }
        }
        // .navigationTitle("Recipe")
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(mealId: "53049")
    }
}
