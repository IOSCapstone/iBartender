import Foundation

struct Cocktail: Codable, Identifiable {
    let id: String
    let strDrink: String
    let strDrinkThumb: String?
    let strInstructions: String?
    let strIngredient1: String?
    let strIngredient2: String?
    let strIngredient3: String?
    let strIngredient4: String?
    let strIngredient5: String?
    let strMeasure1: String?
    let strMeasure2: String?
    let strMeasure3: String?
    let strMeasure4: String?
    let strMeasure5: String?

    private enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case strDrink, strDrinkThumb, strInstructions
        case strIngredient1, strIngredient2, strIngredient3, strIngredient4, strIngredient5
        case strMeasure1, strMeasure2, strMeasure3, strMeasure4, strMeasure5
    }
}
