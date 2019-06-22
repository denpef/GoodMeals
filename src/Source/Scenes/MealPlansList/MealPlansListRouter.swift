import UIKit

// sourcery:begin: AutoMockable
protocol MealPlansListRouterType {
    func navigateToMealPlan(mealPlan: MealPlan)
}

class MealPlansListRouter: MealPlansListRouterType {
    weak var viewController: UIViewController?

    private let factory: ViewControllerFactory

    init(factory: ViewControllerFactory) {
        self.factory = factory
    }

    func navigateToMealPlan(mealPlan: MealPlan) {
        let vc = factory.makeMealPlanViewController(mealPlan: mealPlan)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
