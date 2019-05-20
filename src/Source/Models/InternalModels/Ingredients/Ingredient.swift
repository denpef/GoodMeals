//
//  Ingredient.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/18/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import Foundation

struct Ingredient {
    // MARK: - Properties
    
    var id: String = UUID().uuidString
    var name: String = ""
    var calorific: Int = 0
    var category: IngredientCategory?
    
    // MARK: Init
    
    init(name: String, calorific: Int = 0, category: IngredientCategory? = nil) {
        self.name = name
        self.calorific = calorific
        self.category = category
    }
}

extension Ingredient: Persistable {
    init(managedObject: IngredientObject) {
        self.name = managedObject.name
        self.calorific = managedObject.calorific
        if let category = managedObject.category {
            self.category = IngredientCategory(managedObject: category)
        }
    }
    
    var managedObject: IngredientObject {
        return IngredientObject(name: name,
                                calorific: calorific,
                                category: category?.managedObject)
    }
}
