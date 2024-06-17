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
                    VStack {
                        Text(recipeDetails.name)
                            .font(.largeTitle)
                            .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 10)
                            .accessibilityIdentifier("recipeName")

                        if let thumbnailURL = recipeDetails.thumbnailURL, let url = URL(string: thumbnailURL) {
                            AsyncImage(url: url) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 250)
                                    .cornerRadius(8)
                            } placeholder: {
                                ProgressView()
                            }.padding(.bottom, 20)
                        }

                        Text("Ingredients")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.bottom, 5)

                        ForEach(Array(zip(recipeDetails.ingredients, recipeDetails.measures)), id: \.0) { ingredient, measure in
                            Text("\(ingredient ?? ""): \(measure ?? "")")
                                .padding(.bottom, 2)
                        }

                        Text("Instructions")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .padding(.bottom, 5)

                        // Text(recipeDetails.instructions)
                        VStack(alignment: .leading) {
                            ForEach(viewModel.separateInstructions(recipeDetails.instructions), id: \.self) { instruction in
                                Text(instruction)
                                    .padding(.bottom, 5)
                            }
                        }
                    }
                }
                .scrollIndicators(/*@START_MENU_TOKEN@*/.hidden/*@END_MENU_TOKEN@*/, axes: /*@START_MENU_TOKEN@*/[.vertical, .horizontal]/*@END_MENU_TOKEN@*/)
                .accessibilityIdentifier("recipeDetailView")
            } else if let errorMessage = viewModel.errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundStyle(Color.red)
            } else {
                ProgressView()
                    .task {
                        await viewModel.fetchRecipeDetails(for: mealId)
                    }
            }
        }
        .padding(.horizontal, 20)
        .toolbarTitleDisplayMode(.inline)
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(mealId: "53049")
    }
}
