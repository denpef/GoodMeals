//
//  CellViewModelFactory.swift
//  GoodMeals
//
//  Created by Denis Efimov on 6/20/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import Foundation

protocol CellViewModelFactory {
    func makeGroceryCellViewModel(item: GroceryItem) -> GroceryCellViewModel
}
