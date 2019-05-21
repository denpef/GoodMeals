//
//  IngredientCategory.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/18/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//
import Foundation

struct IngredientCategory {
    // MARK: - Properties
    
    var id: String
    var name: String = ""
    
    // MARK: Convenience Init
    
    init(name: String) {
        self.id = UUID().uuidString
        self.name = name
    }
}

extension IngredientCategory: Persistable {
    init(managedObject: IngredientCategoryObject) {
        self.id = managedObject.id
        self.name = managedObject.name
    }
    
    var managedObject: IngredientCategoryObject {
        return IngredientCategoryObject(id: id, name: name)
    }
}
