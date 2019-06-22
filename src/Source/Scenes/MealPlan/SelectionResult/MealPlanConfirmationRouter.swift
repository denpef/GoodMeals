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
protocol MealPlanConfirmationRouterType {
    func dismiss()
}

class MealPlanConfirmationRouter: MealPlanConfirmationRouterType {
    weak var viewController: UIViewController?

    func dismiss() {
        viewController?.navigationController?.popToRootViewController(animated: true)
    }
}
