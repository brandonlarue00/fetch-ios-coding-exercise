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
            Button(action: { fetchRecipes() }, label: {
                Text("Fetch Recipes")
            })
        }
        .padding()
    }
    
    private func fetchRecipes() {
        APIService.shared.fetchRecipes { result in
            switch result {
            case .success:
                // print("Fetched Meals: \(meals)")
                break
            case .failure:
                // print("Error: \(error.localizedDescription)")
                break
            }
        }
    }
}

struct RecipeListView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeListView()
    }
}
