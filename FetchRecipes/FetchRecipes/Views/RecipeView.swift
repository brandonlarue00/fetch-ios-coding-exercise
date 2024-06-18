//
//  RecipeView.swift
//  FetchRecipes
//
//  Created by Brandon LaRue on 6/15/24.
//

import SwiftUI

struct RecipeView: View {
    let meal: Meal

    var body: some View {
        HStack {
            Text(meal.name ?? "")
                .font(/*@START_MENU_TOKEN@*/ .title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/ .bold/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/ .leading/*@END_MENU_TOKEN@*/)
                .accessibilityIdentifier("recipeName-\(meal.id)")

            Spacer()

            if let thumbnailURL = meal.thumbnailURL, let url = URL(string: thumbnailURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 75, height: 75)
                            .accessibilityIdentifier("recipeThumbnailPlaceholder-\(meal.id)")
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 75)
                            .cornerRadius(10)
                            .accessibilityIdentifier("recipeThumbnail-\(meal.id)")
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 75)
                            .cornerRadius(10)
                            .accessibilityIdentifier("recipeThumbnailError-\(meal.id)")
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 75)
                    .cornerRadius(10)
                    .accessibilityIdentifier("recipeThumbnailUnavailable-\(meal.id)")
            }
        }
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(meal: Meal(id: "53049", name: "Apam balik", thumbnailURL: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"))
    }
}
