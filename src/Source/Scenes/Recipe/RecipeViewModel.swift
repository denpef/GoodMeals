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
    
    let name: BehaviorRelay<String>
    let tap = PublishRelay<Void>()
    
    var recipe: Recipe
    var recipeId: String?
    
    // MARK: - Output
    
    let isSaved = BehaviorRelay<Bool>(value: true)
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    private let recipesService: RecipesServiceType
    
    // MARK: - Init
    
    init(recipesService: RecipesServiceType, recipeId: String?) {
        self.recipesService = recipesService
        self.recipeId = recipeId
        
        if let recipeId = recipeId,
            let recipe = recipesService.getModel(by: recipeId) {
            self.recipe = recipe
        } else {
            recipe = Recipe(name: "", image: "")
            isSaved.accept(false)
        }
        
        name = BehaviorRelay(value: recipe.name)
        name.subscribe(onNext: {
            self.recipe.name = $0
            self.isSaved.accept(false)
        })
            .disposed(by: disposeBag)
        
        tap.subscribe(onNext: {
            if let _ = self.recipeId {
                self.recipesService.update(self.recipe)
            } else {
                self.recipesService.add(self.recipe)
                self.recipeId = self.recipe.id
            }
            self.isSaved.accept(true)
            // router navigate to pop
        }).disposed(by: disposeBag)
    }
}
