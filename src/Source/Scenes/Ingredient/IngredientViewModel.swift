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

struct IngredientViewModel {
    
    // MARK: - Input
    
    // MARK: - Output
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    private let ingredientsService: IngredientsServiceType
    
    // MARK: - Init
    
    init(ingredientsService: IngredientsServiceType, ingredientId: String?) {
        self.ingredientsService = ingredientsService
        //ingredientsService.object
    }
}
