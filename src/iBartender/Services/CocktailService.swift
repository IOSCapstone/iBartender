import Foundation

class CocktailService {
    private let baseURL = "https://www.thecocktaildb.com/api/json/v1/1/"
    
    func fetchTopCocktails(completion: @escaping ([Cocktail]?) -> Void) {
        let urlString = "\(baseURL)filter.php?c=Cocktail"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(CocktailResponse.self, from: data)
                
                var cocktailsWithDetails: [Cocktail] = []
                
                for cocktail in response.drinks ?? [] {
                    cocktailsWithDetails.append(cocktail)   
                }
                
                completion(cocktailsWithDetails)
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
    
    func searchCocktails(query: String, completion: @escaping ([Cocktail]?) -> Void) {
        guard !query.isEmpty, let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)search.php?s=\(encodedQuery)") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                completion(nil)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(CocktailResponse.self, from: data)
                completion(response.drinks)
            } catch {
                print("Decoding error: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}

struct CocktailResponse: Codable {
    let drinks: [Cocktail]?
}
