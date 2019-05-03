//
//  IngredientsService.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/2/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import Foundation

protocol IngredientsService {
    func getIngredients(category: IngredientCategory) -> [Ingredient]
    func add(new: Ingredient)
    func remove(_ ingredient: Ingredient)
    func replace(_ ingredient: Ingredient)
}

final class IngredientsServiceImpl: IngredientsService {
    
    let persistenceService: RealmPersistenceService
    
    init(persistenceService: RealmPersistenceService) {
        self.persistenceService = persistenceService
    }
    
    func getIngredients(category: IngredientCategory) -> [Ingredient] {
        return persistenceService.fetch(with: FetchRequest<Ingredient, IngredientObject>)
    }
    
    func add(new: Ingredient) {
        
    }
    
    func remove(_ ingredient: Ingredient) {
        
    }
    
    func replace(_ ingredient: Ingredient) {
        
    }
}
