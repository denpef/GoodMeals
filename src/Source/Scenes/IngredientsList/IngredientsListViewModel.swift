//
//  IngredientsListViewModel.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/12/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import Foundation
import RxSwift
import RxDataSources

struct IngredientsListViewModel {
    let ingredientsService: IngredientsServiceType
    
    var items: Observable<[Ingredient]>
    
    init(ingredientsService: IngredientsServiceType) {
        self.ingredientsService = ingredientsService
        items = ingredientsService.all()
    }
}

