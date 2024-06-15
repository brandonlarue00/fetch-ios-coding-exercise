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
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Recipes List")
        }
        .padding()
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
