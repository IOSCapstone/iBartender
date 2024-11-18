import SwiftUI

struct CocktailDetailView: View {
    let cocktail: Cocktail
    @State private var isSaved: Bool = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                // Image from Card
                AsyncImage(url: URL(string: cocktail.strDrinkThumb ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 300)
                        .clipped()
                } placeholder: {
                    Rectangle()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 300)
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    HStack {
                        Text(cocktail.strDrink)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Button(action: {
                            isSaved.toggle()
                            // Functionality Missing: Implement Save Button Here
                        }) {
                            Image(systemName: isSaved ? "bookmark.fill" : "bookmark")
                                .font(.title2)
                                .foregroundColor(isSaved ? .blue : .gray)
                        }
                    }
                    
                    // Ingredients Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ingredients")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        ForEach(getIngredients(), id: \.self) { ingredient in
                            if !ingredient.isEmpty {
                                Text("• \(ingredient)")
                                    .font(.body)
                            }
                        }
                    }
                    .padding(.vertical)
                    
                    // Instructions Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Instructions")
                            .font(.title3)
                            .fontWeight(.semibold)
                        
                        Text(cocktail.strInstructions ?? "No instructions available")
                            .font(.body)
                            .lineSpacing(4)
                    }
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // Helper function to get ingredients
    private func getIngredients() -> [String] {
        var ingredients: [String] = []
 
        // Add ingredients...
        if let ingredient1 = cocktail.strIngredient1 { ingredients.append(ingredient1) }
        if let ingredient2 = cocktail.strIngredient2 { ingredients.append(ingredient2) }
        // ... add more ingredients as needed
        return ingredients
    }
}

