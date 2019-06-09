import UIKit

protocol ViewControllerFactory {
    func makeTodayMenuViewController() -> TodayMenuViewController
    func makeShoppingListViewController() -> ShoppingListViewController
    func makeIngredientsListViewController() -> IngredientsListViewController
    func makeIngredientViewController(ingredientId: String?) -> IngredientViewController
    func makeRecipesListViewController() -> RecipesListViewController
    func makeRecipeViewController(recipeId: String?) -> RecipeViewController
}
