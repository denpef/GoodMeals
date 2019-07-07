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
        let router = RecipesListRouter(factory: self)
        let vm = RecipesListViewModel(recipesService: serviceContainer.recipesService, router: router)
        let vc = RecipesListViewController(viewModel: vm)

        router.viewController = vc
        return vc
    }

    func makeRecipeViewController(recipeId: String) -> RecipeViewController {
        let vm = RecipeViewModel(recipesService: serviceContainer.recipesService,
                                 shoppingListService: serviceContainer.shoppingListService,
                                 recipeId: recipeId)
        return RecipeViewController(viewModel: vm)
    }

    func makeTodayMenuViewController() -> TodayMenuViewController {
        let router = TodayMenuRouter(factory: self)
        let vm = TodayMenuViewModel(mealPlanService: serviceContainer.mealPlanService, router: router)
        let vc = TodayMenuViewController(viewModel: vm)

        router.viewController = vc
        return vc
    }

    func makeShoppingListViewController() -> ShoppingListViewController {
        let vm = ShoppingListViewModel(shoppingListService: serviceContainer.shoppingListService)
        return ShoppingListViewController(viewModel: vm)
    }

    func makeMealPlansListViewController() -> MealPlansListViewController {
        let router = MealPlansListRouter(factory: self)
        let vm = MealPlansListViewModel(mealPlanService: serviceContainer.mealPlanService, router: router)
        let vc = MealPlansListViewController(viewModel: vm)

        router.viewController = vc
        return vc
    }

    func makeMealPlanViewController(mealPlan: MealPlan) -> MealPlanViewController {
        let router = MealPlanRouter(factory: self)
        let vm = MealPlanViewModel(mealPlan: mealPlan, router: router)
        let vc = MealPlanViewController(viewModel: vm)

        router.viewController = vc
        return vc
    }

    func makeMealPlanConfirmationViewController(mealPlan: MealPlan) -> MealPlanConfirmationViewController {
        let router = MealPlanConfirmationRouter()
        let vm = MealPlanConfirmationViewModel(mealPlanService: serviceContainer.mealPlanService,
                                               mealPlan: mealPlan,
                                               router: router)

        let vc = MealPlanConfirmationViewController(viewModel: vm)

        router.viewController = vc
        return vc
    }
}
