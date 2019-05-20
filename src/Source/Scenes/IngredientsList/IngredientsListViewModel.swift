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

struct IngredientsListViewModel {

    // MARK: - Input
    
    /// Call to show add new item screen
    let addNewItem: PublishRelay<Void> = PublishRelay<Void>()

    /// Call to open item page
    let selectItem: PublishRelay<IngredientObject> = PublishRelay<IngredientObject>()
    
    // MARK: - Output
    
    var items: BehaviorRelay<[IngredientObject]>

    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    private let ingredientsService: IngredientsServiceType
    
    // MARK: - Init
    
    init(ingredientsService: IngredientsServiceType) {
        self.ingredientsService = ingredientsService
        
        items = ingredientsService.all()
        
        selectItem.asObservable().subscribe(onNext: {
            print($0.name)
        }).disposed(by: disposeBag)
        
        addNewItem.asObservable().subscribe(onNext: {
            print("add+")
        }).disposed(by: disposeBag)
    }
}

