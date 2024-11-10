//
//  CocktailModel.swift
//  iBartender
//
//  Created by Amin Carbonell on 11/9/24.
//

import Foundation

struct Cocktail: Identifiable, Codable {
    let idDrink: String
    let strDrink: String
    let strDrinkThumb: String?
    let strInstructions: String?
    
    var id: String { idDrink } // Use `idDrink` as the unique identifier
}
