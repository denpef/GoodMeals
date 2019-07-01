import UIKit

// sourcery:begin: AutoMockable
protocol MealPlanRouterType {
    func navigateToConfirmation(mealPlan: MealPlan)
    func navigateToRecipe(recipeId: String)
}

class MealPlanRouter: MealPlanRouterType {
    weak var viewController: UIViewController?

    private let factory: ViewControllerFactory

    init(factory: ViewControllerFactory) {
        self.factory = factory
    }

    func navigateToConfirmation(mealPlan: MealPlan) {
        let vc = factory.makeMealPlanConfirmationViewController(mealPlan: mealPlan)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func navigateToRecipe(recipeId: String) {
        let vc = factory.makeRecipeViewController(recipeId: recipeId)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
