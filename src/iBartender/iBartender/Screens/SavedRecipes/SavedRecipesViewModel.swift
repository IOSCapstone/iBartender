//
//  SavedRecipesViewModel.swift
//  BarsNearYou
//
//  Created by christian de angelo orozco on 11/13/24.
//

import SwiftUI
import FirebaseFirestore

// MARK: - Saved Recipes View
struct SavedRecipesView: View {
    @StateObject private var viewModel = SavedRecipesViewModel()

    var body: some View {
        VStack {
            Text("Saved Recipes")
                .font(.largeTitle)
                .padding()

            if viewModel.recipes.isEmpty {
                Text("No saved recipes yet.")
                    .foregroundColor(.gray)
            } else {
                List(viewModel.recipes) { recipe in
                    VStack(alignment: .leading) {
                        Text(recipe.name)
                            .font(.headline)
                        if let description = recipe.description {
                            Text(description)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchSavedRecipes()
        }
    }
}

// MARK: - Saved Recipes ViewModel
class SavedRecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    private var db = Firestore.firestore()

    func fetchSavedRecipes() {
        db.collection("saved_recipes").getDocuments { [weak self] (querySnapshot, error) in
            if let error = error {
                print("Error fetching recipes: \(error)")
                return
            }

            self?.recipes = querySnapshot?.documents.compactMap { document in
                try? document.data(as: Recipe.self)
            } ?? []
        }
    }
}

// MARK: - Recipe Model
struct Recipe: Identifiable, Codable {
    @DocumentID var id: String?
    let name: String
    let description: String?
}

#Preview {
    SavedRecipesView()
}
