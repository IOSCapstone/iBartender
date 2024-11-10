//
//  CocktailService.swift
//  iBartender
//
//  Created by Amin Carbonell on 11/9/24.
//
import Foundation

class CocktailService {
    private let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/"
    
    func searchCocktails(query: String, completion: @escaping ([Cocktail]?) -> Void) {
        let urlString = "\(baseURL)search.php?s=\(query)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            do {
                let response = try JSONDecoder().decode(CocktailResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.drinks)
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    func fetchTopCocktails(completion: @escaping ([Cocktail]?) -> Void) {
        let urlString = "\(baseURL)filter.php?c=Cocktail"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            do {
                let response = try JSONDecoder().decode(CocktailResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(response.drinks)
                }
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}

// Response model for decoding the JSON structure from API
struct CocktailResponse: Codable {
    let drinks: [Cocktail]?
}

