//
//  LandingPageView.swift
//  iBartender
//
//  Created by Amin Carbonell on 11/9/24.
//

import SwiftUI

struct CocktailFeedView: View {
    @State private var searchText: String = ""
    @State private var cocktails: [Cocktail] = []
    @State private var topCocktails: [Cocktail] = []
    private let cocktailService = CocktailService()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 12) {
                    
                    HStack {
                        NavigationLink(destination: BarsNearYouView()) {
                            Image(systemName: "wineglass").font(.system(size: 20))
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: SavedRecipesView()) {
                            Image(systemName: "book").font(.system(size: 20))
                        }
                    }
                    .padding()
                    
                    Text("Find Cocktails").font(.headline)
                    
                    // Search Bar
                    TextField("Search for cocktails or ingredients", text: $searchText, onCommit: {
                        searchCocktails()
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.all)

                    // Cocktail Feed
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(topCocktails) { cocktail in
                                HStack {
                                    
                                    // Cocktail Image
                                    AsyncImage(url: URL(string: cocktail.strDrinkThumb ?? "")) { image in
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 80, height: 80)
                                            .clipShape(Circle())
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: 80, height: 80)

                                    // Cocktail Name and Instructions
                                    VStack(alignment: .leading, spacing: 4) {
                                        Text(cocktail.strDrink)
                                            .font(.headline)
                                        if let instructions = cocktail.strInstructions {
                                            Text(instructions)
                                                .font(.subheadline)
                                                .lineLimit(2)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    Spacer() // Push content to the left
                                    
                                    
                                    // Save Recipe Button (Heart Icon)
                                    Button(action: {
                                        
                                    }) {
                                        Image(systemName: "heart")
                                            .font(.system(size: 18))
                                    }

                                }
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 450)

                    // Search Results Section
                    if !cocktails.isEmpty {
                        Text("Search Results")
                            .font(.headline)
                            .padding(.top)

                        VStack(spacing: 16) {
                            ForEach(cocktails) { cocktail in
                                VStack(alignment: .leading) {
                                    Text(cocktail.strDrink)
                                        .font(.headline)
                                    if let instructions = cocktail.strInstructions {
                                        Text(instructions)
                                            .font(.subheadline)
                                            .lineLimit(2)
                                    }
                                }
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(8)
                                .frame(maxWidth: 340) // Center the search results
                            }
                        }
                        .padding(.horizontal)
                    }
                }
                .padding()
            }
            .onAppear {
                fetchTopCocktails()
            }
        }
    }
    
    private func searchCocktails() {
        cocktailService.searchCocktails(query: searchText) { result in
            cocktails = result ?? []
        }
    }
    
    private func fetchTopCocktails() {
        cocktailService.fetchTopCocktails { result in
            topCocktails = result ?? []
        }
    }
}

#Preview {
    CocktailFeedView()
}
