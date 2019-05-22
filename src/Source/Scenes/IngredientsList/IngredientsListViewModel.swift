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
    let addNewItem = PublishRelay<Void>()

    /// Call to open item page
    let selectItem = PublishRelay<Ingredient>()
    
    // MARK: - Output
    
    var items: BehaviorRelay<[Ingredient]>

    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    private let ingredientsService: IngredientsServiceType
    
    // MARK: - Init
    
    init(ingredientsService: IngredientsServiceType) {
        self.ingredientsService = ingredientsService
        
        items = ingredientsService.all()
        
        selectItem.asObservable().subscribe(onNext: { [weak self] in
            self?.router?.navigateToIngredient(ingredientId: $0.id)
        }).disposed(by: disposeBag)
        
        addNewItem.asObservable().subscribe(onNext: { [weak self] in
            self?.router?.navigateToIngredient(ingredientId: nil)
        }).disposed(by: disposeBag)
    }
    
}
