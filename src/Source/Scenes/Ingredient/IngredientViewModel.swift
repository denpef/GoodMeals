//
//  IngredientViewModel.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/22/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class IngredientViewModel {
    
    // MARK: - Input
    
    let editMode = BehaviorRelay<Bool>(value: true)
    let name: BehaviorRelay<String>
    let tap = PublishRelay<Void>()
    
    var ingredient: Ingredient
    var ingredientId: String?
    
    // MARK: - Output
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    private let ingredientsService: IngredientsServiceType
    
    // MARK: - Init
    
    init(ingredientsService: IngredientsServiceType, ingredientId: String?) {
        self.ingredientsService = ingredientsService
        self.ingredientId = ingredientId
        
        if let ingredientId = ingredientId {
            if let ingredient = ingredientsService.getModel(by: ingredientId) {
                self.ingredient = ingredient
            } else {
                ingredient = Ingredient(name: "")
                editMode.accept(false)
            }
        } else {
            ingredient = Ingredient(name: "")
            editMode.accept(false)
        }
        
        name = BehaviorRelay(value: ingredient.name)
        name.subscribe(onNext: { [weak self] in
                self?.ingredient.name = $0
                self?.editMode.accept(false)
            })
            .disposed(by: disposeBag)
        
        tap.subscribe(onNext: { [weak self] in
                guard let self = self else {
                    return
                }
                if let _ = self.ingredientId {
                    self.ingredientsService.update(self.ingredient)
                } else {
                    self.ingredientsService.add(self.ingredient)
                    self.ingredientId = self.ingredient.id
                }
                self.editMode.accept(true)
                // router navigate to pop
        }).disposed(by: disposeBag)
    }
}
