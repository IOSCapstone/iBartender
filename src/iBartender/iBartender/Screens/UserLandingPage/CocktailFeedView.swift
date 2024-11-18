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
                VStack(spacing: 20) {
                    // Search Bar
                    TextField("Search for a cocktail or ingredient", text: $searchText, onCommit: {
                        searchCocktails()
                    })
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .frame(maxWidth: 300) // Center the search bar with a fixed width

                    // Top Cocktails Section
                    Text("Top Cocktails")
                        .font(.headline)
                        .padding(.top)

                    // Limited height for the top cocktails section
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
                                }
                                .padding()
                                .background(Color(.secondarySystemBackground))
                                .cornerRadius(8)
                                .frame(maxWidth: 340) // Center the items within the screen width
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 450) // Limit the height of the scroll view for top cocktails

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
            .navigationBarTitle("Find Cocktails", displayMode: .inline)
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
