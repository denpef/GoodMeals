//
//  IngredientsListViewModel.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/12/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class IngredientsListViewModel {
    
    var router: IngredientsListRouter?
    
    // MARK: - Input
    
    /// Call to show add new item screen
    let addNewItem = PublishSubject<Void>()

    /// Call to open item page
    let selectItem = PublishSubject<Ingredient>()
    
    // MARK: - Output
    
    var items: BehaviorSubject<[Ingredient]>

    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    private let ingredientsService: IngredientsServiceType
    
    // MARK: - Init
    
    init(ingredientsService: IngredientsServiceType) {
        self.ingredientsService = ingredientsService
        
        items = ingredientsService.all()
        
        selectItem.subscribe(onNext: { [weak self] ingredient in
                self?.router?.navigateToIngredient(ingredientId: ingredient.id)
            }).disposed(by: disposeBag)
        
        addNewItem
            .subscribe(onNext: { [weak self] in
                self?.router?.navigateToIngredient(ingredientId: nil)
            }).disposed(by: disposeBag)
    }
    
}
