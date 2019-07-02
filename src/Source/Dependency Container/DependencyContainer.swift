import UIKit

class DependencyContainer {
    let serviceContainer: ServiceContainerType

    init(serviceContainer: ServiceContainerType) {
        self.serviceContainer = serviceContainer
    }
}

// MARK: - ViewController Factory -

extension DependencyContainer: ViewControllerFactory {
    func makeRecipesListViewController() -> RecipesListViewController {
        let vm = RecipesListViewModel(recipesService: serviceContainer.recipesService)
        let router = RecipesListRouter(factory: self)
        let vc = RecipesListViewController(viewModel: vm)

        vm.router = router
        router.viewController = vc
        return vc
    }

    func makeRecipeViewController(recipeId: String) -> RecipeViewController {
        let vm = RecipeViewModel(recipesService: serviceContainer.recipesService,
                                 shoppingListService: serviceContainer.shoppingListService,
                                 recipeId: recipeId)
        return RecipeViewController(viewModel: vm)
    }

    func makeIngredientViewController(ingredientId: String?) -> IngredientViewController {
        let vm = IngredientViewModel(ingredientsService: serviceContainer.ingredientsService,
                                     ingredientId: ingredientId)
        return IngredientViewController(viewModel: vm)
    }

    func makeTodayMenuViewController() -> TodayMenuViewController {
        let vm = TodayMenuViewModel(mealPlanService: serviceContainer.mealPlanService)
        let router = TodayMenuRouter(factory: self)
        let vc = TodayMenuViewController(viewModel: vm)

        vm.router = router
        router.viewController = vc
        return vc
    }

    func makeShoppingListViewController() -> ShoppingListViewController {
        let vm = ShoppingListViewModel(shoppingListService: serviceContainer.shoppingListService)
        return ShoppingListViewController(viewModel: vm)
    }

    func makeMealPlansListViewController() -> MealPlansListViewController {
        let vm = MealPlansListViewModel(persistanceService: serviceContainer.persistenceService)
        let router = MealPlansListRouter(factory: self)
        let vc = MealPlansListViewController(viewModel: vm)

        vm.router = router
        router.viewController = vc
        return vc
    }

    func makeMealPlanViewController(mealPlan: MealPlan) -> MealPlanViewController {
        let vm = MealPlanViewModel(mealPlanService: serviceContainer.mealPlanService, mealPlan: mealPlan)
        let router = MealPlanRouter(factory: self)
        let vc = MealPlanViewController(viewModel: vm)

        vm.router = router
        router.viewController = vc
        return vc
    }

    func makeMealPlanConfirmationViewController(mealPlan: MealPlan) -> MealPlanConfirmationViewController {
        let vm = MealPlanConfirmationViewModel(mealPlanService: serviceContainer.mealPlanService,
                                               mealPlan: mealPlan)
        let router = MealPlanConfirmationRouter()
        let vc = MealPlanConfirmationViewController(viewModel: vm)

        vm.router = router
        router.viewController = vc
        return vc
    }
}

extension DependencyContainer: CellViewModelFactory {
    func makeGroceryCellViewModel(item: GroceryItem) -> GroceryCellViewModel {
        return GroceryCellViewModel(with: item)
    }
}
