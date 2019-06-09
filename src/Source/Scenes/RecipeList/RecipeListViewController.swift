//
//  RecipesListViewModel.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/12/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

class RecipesListViewModel {
    
    var router: RecipesListRouterType?
    
    // MARK: - Input
    
    /// Call to show add new item screen
    let addNewItem = PublishSubject<Void>()
    
    /// Call to open item page
    let selectItem = PublishSubject<Recipe>()
    
    // MARK: - Output
    
    var items: BehaviorSubject<[Recipe]>
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    private let recipesService: RecipesServiceType
    
    // MARK: - Init
    
    init(recipesService: RecipesServiceType) {
        self.recipesService = recipesService
        
        items = BehaviorSubject(value: recipesService.all())
        
        recipesService.subscribeCollection(subscriber: self)
        
        selectItem.subscribe(onNext: { [weak self] recipe in
            self?.router?.navigateToRecipe(recipeId: recipe.id)
        }).disposed(by: disposeBag)
        
        addNewItem
            .subscribe(onNext: { [weak self] in
                self?.router?.navigateToRecipe(recipeId: nil)
            }).disposed(by: disposeBag)
    }
    
}

extension RecipesListViewModel: PersistenceNotificationOutput {
    func didChanged<T>(_ changes: PersistenceNotification<T>) {
        if let changes = changes as? PersistenceNotification<Recipe> {
            switch changes {
            case let .error(error):
                break
            case let .initial(objects):
                items.on(.next(recipesService.all()))
            case let .update(objects, deletions, insertions, modifications):
                items.on(.next(recipesService.all()))
            }
        }
    }
}