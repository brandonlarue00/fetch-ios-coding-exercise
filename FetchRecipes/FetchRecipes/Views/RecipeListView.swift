//
//  ContentView.swift
//  FetchRecipes
//
//  Created by Brandon LaRue on 6/14/24.
//

import SwiftUI

struct RecipeListView: View {
    var body: some View {
        VStack {
            Button(action: { APIService.shared.fetchRecipes() }, label: {
                Text("Fetch Recipes")
            })
        }
        .padding()
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
