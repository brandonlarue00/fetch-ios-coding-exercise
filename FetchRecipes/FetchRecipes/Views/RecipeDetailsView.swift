//
//  RecipeDetailsView.swift
//  FetchRecipes
//
//  Created by Brandon LaRue on 6/17/24.
//

import SwiftUI

struct RecipeDetailsView: View {
    @State private var recipeDetails: RecipeDetails?
    @State private var errorMessage: String?
    let mealId: String

    var body: some View {
        VStack {
            if let recipeDetails = recipeDetails {
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
                            Text("\(ingredient): \(measure)")
                                .padding(.bottom, 2)
                        }

                        Text("Instructions")
                            .font(.headline)
                            .padding(.bottom, 5)
                        
                        Text(recipeDetails.instructions)
                    }
                }
            } else if let errorMessage = errorMessage {
                Text("Error: \(errorMessage)")
                    .foregroundStyle(Color.red)
            } else {
                ProgressView()
                    .onAppear {
                        fetchRecipeDetails(for: mealId)
                    }
            }
        }
        .navigationTitle("Recipe")
    }
    
    private func fetchRecipeDetails(for id: String) {
        APIService.shared.fetchRecipeDetails(for: id) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipeDetails):
                    self.recipeDetails = recipeDetails
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

struct RecipeDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeDetailsView(mealId: "53049")
    }
}
