import UIKit

// sourcery:begin: AutoMockable
protocol RecipesListRouterType {
    func navigateToRecipe(recipeId: String)
}

class RecipesListRouter: RecipesListRouterType {
    weak var viewController: UIViewController?

    private let factory: ViewControllerFactory

    init(factory: ViewControllerFactory) {
        self.factory = factory
    }

    func navigateToRecipe(recipeId: String) {
        let vc = factory.makeRecipeViewController(recipeId: recipeId)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
