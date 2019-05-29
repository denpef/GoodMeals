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
    
    var router: IngredientsListRouterType?
    
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
        
        items = BehaviorSubject(value: ingredientsService.all())
        
        ingredientsService.subscribeCollection(subscriber: self)
        
        selectItem.subscribe(onNext: { [weak self] ingredient in
                self?.router?.navigateToIngredient(ingredientId: ingredient.id)
            }).disposed(by: disposeBag)
        
        addNewItem
            .subscribe(onNext: { [weak self] in
                self?.router?.navigateToIngredient(ingredientId: nil)
            }).disposed(by: disposeBag)
    }
    
}

extension IngredientsListViewModel: PersistenceNotificationOutput {
    func didChanged<T>(_ changes: PersistenceNotification<T>) {
        if let changes = changes as? PersistenceNotification<Ingredient> {
            switch changes {
            case let .error(error):
                break
            case let .initial(objects):
                items.on(.next(ingredientsService.all()))
            case let .update(objects, deletions, insertions, modifications):
                items.on(.next(ingredientsService.all()))
            }
        }
    }
}
