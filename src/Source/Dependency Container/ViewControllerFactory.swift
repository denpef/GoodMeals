import UIKit

protocol ViewControllerFactory {
    func makeMealPlanSelectionResultViewController() -> MealPlanSelectionResultViewController
    func makeMealPlanDateSelectionViewController(mealPlan: MealPlan) -> MealPlanDateSelectionViewController
    func makeMealPlanViewController(mealPlan: MealPlan) -> MealPlanViewController
    func makeMealPlansListViewController() -> MealPlansListViewController
    func makeTodayMenuViewController() -> TodayMenuViewController
    func makeShoppingListViewController() -> ShoppingListViewController
    func makeIngredientsListViewController() -> IngredientsListViewController
    func makeIngredientViewController(ingredientId: String?) -> IngredientViewController
    func makeRecipesListViewController() -> RecipesListViewController
    func makeRecipeViewController(recipeId: String?) -> RecipeViewController
}
