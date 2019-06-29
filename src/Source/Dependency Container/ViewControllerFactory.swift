import UIKit

protocol ViewControllerFactory {
    func makeMealPlanConfirmationViewController(mealPlan: MealPlan) -> MealPlanConfirmationViewController
    func makeMealPlanViewController(mealPlan: MealPlan) -> MealPlanViewController
    func makeMealPlansListViewController() -> MealPlansListViewController
    func makeTodayMenuViewController() -> TodayMenuViewController
    func makeShoppingListViewController() -> ShoppingListViewController
    func makeIngredientViewController(ingredientId: String?) -> IngredientViewController
    func makeRecipesListViewController() -> RecipesListViewController
    func makeRecipeViewController(recipeId: String) -> RecipeViewController
}
