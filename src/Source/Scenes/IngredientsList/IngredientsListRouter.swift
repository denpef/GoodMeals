import UIKit

protocol IngredientsListRouterType {
    func navigateToIngredient(ingredientId: String?)
}

class IngredientsListRouter: IngredientsListRouterType {
    weak var viewController: UIViewController?
    
    private let factory: ViewControllerFactory
    
    init(factory: ViewControllerFactory) {
        self.factory = factory
    }
    
    func navigateToIngredient(ingredientId: String?) {
        let vc = factory.makeIngredientViewController(ingredientId: ingredientId)
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
}
