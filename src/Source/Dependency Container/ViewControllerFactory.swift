protocol ViewControllerFactory {
    func makeRecipesListViewController() -> RecipesListViewController
    func makeMealPlansListViewController() -> MealPlansListViewController
    func makeShoppingListViewController() -> ShoppingListViewController
    func makeMealPlanConfirmationViewController(mealPlan: MealPlan) -> MealPlanConfirmationViewController
    func makeMealPlanViewController(mealPlan: MealPlan) -> MealPlanViewController
    func makeTodayMenuViewController() -> TodayMenuViewController
    func makeRecipeViewController(recipeId: String) -> RecipeViewController
}
