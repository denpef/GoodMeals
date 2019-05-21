import UIKit

protocol ViewControllerFactory {
    func makeNavigationController(rootViewController: UIViewController) -> UINavigationController
    func makeIngredientsListViewController() -> IngredientsListViewController
    func makeIngredientViewController(ingredientId: String?) -> IngredientViewController
}
