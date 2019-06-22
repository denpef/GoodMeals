//
//  RecipeCategory.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/18/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//
import Foundation

struct RecipeCategory {
    // MARK: - Properties

    var id: String
    var name: String = ""

    // MARK: Convenience Init

    init(name: String) {
        id = UUID().uuidString
        self.name = name
    }
}

extension RecipeCategory: Persistable {
    init(managedObject: RecipeCategoryObject) {
        id = managedObject.id
        name = managedObject.name
    }

    var managedObject: RecipeCategoryObject {
        return RecipeCategoryObject(id: id, name: name)
    }
}
