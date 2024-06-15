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
            Spacer()
            
            AsyncImage(url: URL(string: meal.thumbnailURL),
                       content: { image in
                           image.resizable()
                               .aspectRatio(contentMode: .fit)
                               .frame(height: 75)
                               .cornerRadius(/*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                       },
                       placeholder: {
                           ProgressView()
                       })
            // .aspectRatio(contentMode: .)
            // .frame(width: 50, height: 50)
            // .cornerRadius(10)

            Spacer()
            Spacer()

            Text(meal.name)
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            Spacer()
        }
        // .padding(.horizontal, 20)
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView(meal: Meal(id: "53049", name: "Apam balik", thumbnailURL: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"))
    }
}
