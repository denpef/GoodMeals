//
//  Recipe.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/18/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import Foundation

struct Recipe {
    // MARK: - Properties
    
    var id: String
    var ingredients = [Ingredient]()
    var name: String = ""
    var calorific: Int = 0
    var category: RecipeCategory?
    var image: String = ""
    
    // MARK: Init
    
    init(name: String, image: String, calorific: Int = 0, category: RecipeCategory? = nil) {
        self.id = UUID().uuidString
        self.name = name
        self.image = image
        self.calorific = calorific
        self.category = category
    }
}

extension Recipe: Persistable {
    init(managedObject: RecipeObject) {
        self.id = managedObject.id
        self.name = managedObject.name
        self.image = managedObject.image
        self.ingredients = managedObject.ingredients.map { Ingredient(managedObject: $0) }
        self.calorific = managedObject.calorific
        if let category = managedObject.category {
            self.category = RecipeCategory(managedObject: category)
        }
    }
    
    var managedObject: RecipeObject {
        return RecipeObject(id: id,
                            name: name,
                            image: image,
                            ingredients: ingredients.map { $0.managedObject },
                            category: category?.managedObject,
                            calorific: calorific)
    }
}
