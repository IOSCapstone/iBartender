import SwiftUI

struct CocktailFeedView: View {
    @State private var searchText: String = ""
    @State private var cocktails: [Cocktail] = []
    private let cocktailService = CocktailService()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                HStack {
                    NavigationLink(destination: BarsNearYouView()) {
                        Image(systemName: "wineglass")
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                            .frame(width: 40, height: 40)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Circle())
                    }

                    Spacer()

                    Text("iBartender")
                        .font(.title2)
                        .fontWeight(.bold)

                    Spacer()

                    NavigationLink(destination: SavedRecipesView()) {
                        Image(systemName: "book")
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                            .frame(width: 40, height: 40)
                            .background(Color.gray.opacity(0.1))
                            .clipShape(Circle())
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)

                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)

                    TextField("Search for cocktails or ingredients", text: $searchText)
                        .onSubmit {
                            searchCocktails()
                        }

                    if !searchText.isEmpty {
                        Button(action: {
                            searchText = ""
                            cocktails = []
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(15)
                .padding(.horizontal)
                .padding(.top, 8)
                .padding(.bottom, 8)

                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        if !cocktails.isEmpty {
                            VStack(alignment: .leading, spacing: 12) {
                                ForEach(cocktails) { cocktail in
                                    CocktailCard(cocktail: cocktail)
                                }
                            }
                        }
                    }
                }
            }
            .background(Color(.systemBackground))
            .onAppear {
                fetchTopCocktails()
            }
        }
    }

    private func fetchTopCocktails() {
        cocktailService.fetchTopCocktails { result in
            cocktails = result ?? []
        }
    }

    private func searchCocktails() {
        cocktailService.searchCocktails(query: searchText) { result in
            cocktails = result ?? []
        }
    }
}

struct CocktailCard: View {
    let cocktail: Cocktail
    @State private var isFavorite: Bool = false

    var body: some View {
        NavigationLink(destination: CocktailDetailView(cocktail: cocktail)) {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: cocktail.strDrinkThumb ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 70, height: 70)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                } placeholder: {
                    ProgressView()
                        .frame(width: 70, height: 70)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }

                VStack(alignment: .leading, spacing: 4) {
                    Text(cocktail.strDrink)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)

                    if let instructions = cocktail.strInstructions {
                        Text(instructions)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                    }

                    if let ingredient1 = cocktail.strIngredient1 {
                        Text(ingredient1)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    if let ingredient2 = cocktail.strIngredient2 {
                        Text(ingredient2)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    if let ingredient3 = cocktail.strIngredient3 {
                        Text(ingredient3)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    if let ingredient4 = cocktail.strIngredient4 {
                        Text(ingredient4)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }

                Spacer()

                Button(action: {
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .font(.system(size: 20))
                        .foregroundColor(isFavorite ? .red : .gray)
                }
                .padding(.leading, 8)
            }
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        }
        .padding(.horizontal)
    }
}

#Preview {
    CocktailFeedView()
}
