//
//  MealPlanDateSelectionRouter.swift
//  GoodMeals
//
//  Created by Denis Efimov on 6/12/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import Foundation
import UIKit

// sourcery:begin: AutoMockable
protocol MealPlanDateSelectionRouterType {
    func navigateToResult()
}

class MealPlanDateSelectionRouter: MealPlanDateSelectionRouterType {
    weak var viewController: UIViewController?
    
    private let factory: ViewControllerFactory
    
    init(factory: ViewControllerFactory) {
        self.factory = factory
    }
    
    func navigateToResult() {
        let vc = factory.makeMealPlanSelectionResultViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
