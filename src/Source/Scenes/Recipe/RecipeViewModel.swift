//
//  RecipeViewModel.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/22/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


class RecipeViewModel {
    
    // MARK: - Input
    
    let serving = BehaviorRelay<Int>(value: 2)
    let name: BehaviorRelay<String>
    let addToShoppingList = PublishRelay<Void>()
    let inShoppingList = BehaviorRelay<Bool>(value: false)
    
//    let tap = PublishRelay<Void>()
    let items: BehaviorSubject<[RecipeSection]>
    
    var recipe: Recipe
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    private let recipesService: RecipesServiceType
    private let shoppingListService: ShoppingListServiceType
    
    // MARK: - Init
    
    init(recipesService: RecipesServiceType, shoppingListService: ShoppingListServiceType, recipeId: String) {
        self.recipesService = recipesService
        self.shoppingListService = shoppingListService
        self.recipe = recipesService.getModel(by: recipeId)!
        
        name = BehaviorRelay(value: recipe.name)
        
        var items = [RecipeItem]()
        items.append(.RecipeInfoItem(calorific: recipe.calorific, timeForPreparing: recipe.timeForPreparing))
        items.append(.ServingItem)
        recipe.ingredients.forEach {
            items.append(.IngredientItem(ingredient: $0))
        }
        self.items = BehaviorSubject(value: [RecipeSection(items: items)])
        
        serving.subscribe(onNext: { (val) in
            print("\(self.serving.value)")
        }).disposed(by: disposeBag)
        
        addToShoppingList.subscribe(onNext: { [weak self] _ in
            guard let self = self else {
                return
            }
            self.recipe.ingredients.forEach {
                let item = GroceryItem(ingredient: $0.ingredient,
                                       amount: $0.amount * Float(self.serving.value),
                                       marked: false)
                self.shoppingListService.add(item)
            }
        }).disposed(by: disposeBag)
//        tap.subscribe(onNext: {
//            if let _ = self.recipeId {
//                self.recipesService.update(self.recipe)
//            } else {
//                self.recipesService.add(self.recipe)
//                self.recipeId = self.recipe.id
//            }
//            self.isSaved.accept(true)
//            // router navigate to pop
//        }).disposed(by: disposeBag)
    }
}
