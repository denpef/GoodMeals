import UIKit

// sourcery:begin: AutoMockable
protocol TodayMenuRouterType {
    func navigateToMealPlansList()
    func navigateToRecipe(recipeId: String)
}

class TodayMenuRouter: TodayMenuRouterType {
    weak var viewController: UIViewController?

    private let factory: ViewControllerFactory

    init(factory: ViewControllerFactory) {
        self.factory = factory
    }

    func navigateToMealPlansList() {
        let vc = factory.makeMealPlansListViewController()
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }

    func navigateToRecipe(recipeId: String) {
        let vc = factory.makeRecipeViewController(recipeId: recipeId)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
