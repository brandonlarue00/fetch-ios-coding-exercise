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
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
            
            Spacer()
            
            if let thumbnailURL = meal.thumbnailURL, let url = URL(string: thumbnailURL) {
                AsyncImage(url: url,
                           content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 75)
                        .cornerRadius(10)
                },
                           placeholder: {
                    ProgressView()
                })
            }
            // .aspectRatio(contentMode: .)
            // .frame(width: 50, height: 50)
            // .cornerRadius(10)
        }
        // .padding(.horizontal, 10)
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(meal: Meal(id: "53049", name: "Apam balik", thumbnailURL: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"))
    }
}
