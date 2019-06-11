import UIKit

// sourcery:begin: AutoMockable
protocol MealPlanRouterType {
    func navigateToDateSelection(mealPlan: MealPlan)
}

class MealPlanRouter: MealPlanRouterType {
    weak var viewController: UIViewController?
    
    private let factory: ViewControllerFactory
    
    init(factory: ViewControllerFactory) {
        self.factory = factory
    }
    
    func navigateToDateSelection(mealPlan: MealPlan) {
        let vc = factory.makeMealPlanDateSelectionViewController(mealPlan: mealPlan)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
