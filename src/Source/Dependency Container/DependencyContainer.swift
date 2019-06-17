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
        let vm = makeRecipesListViewModel()
        let router = RecipesListRouter(factory: self)
        let vc = RecipesListViewController(viewModel: vm)
        
        vm.router = router
        router.viewController = vc
        return vc
    }
    
    func makeRecipeViewController(recipeId: String) -> RecipeViewController {
        let vm = makeRecipeViewModel(recipeId)
        return RecipeViewController(viewModel: vm)
    }
    
    func makeIngredientViewController(ingredientId: String?) -> IngredientViewController {
        let vm = makeIngredientViewModel(ingredientId)
        return IngredientViewController(viewModel: vm)
    }
    
    func makeIngredientsListViewController() -> IngredientsListViewController {
        let vm = makeIngredientsListViewModel()
        let router = IngredientsListRouter(factory: self)
        let vc = IngredientsListViewController(viewModel: vm)
        
        vm.router = router
        router.viewController = vc
        return vc
    }
    
    func makeTodayMenuViewController() -> TodayMenuViewController {
        let vm = makeTodayMenuViewModel()
        return TodayMenuViewController(viewModel: vm)
    }
    
    func makeShoppingListViewController() -> ShoppingListViewController {
        let vm = makeShoppingListViewModel()
        return ShoppingListViewController(viewModel: vm)
    }
    
    func makeMealPlansListViewController() -> MealPlansListViewController {
        let vm = makeMealPlansListViewModel()
        let router = MealPlansListRouter(factory: self)
        let vc = MealPlansListViewController(viewModel: vm)
        
        vm.router = router
        router.viewController = vc
        return vc
    }
    
    func makeMealPlanViewController(mealPlan: MealPlan) -> MealPlanViewController {
        let vm = makeMealPlanViewModel(mealPlan: mealPlan)
        let router = MealPlanRouter(factory: self)
        let vc = MealPlanViewController(viewModel: vm)
        
        vm.router = router
        router.viewController = vc
        return vc
    }
    
    func makeMealPlanDateSelectionViewController(mealPlan: MealPlan) -> MealPlanDateSelectionViewController {
        let vm = MealPlanDateSelectionViewModel(mealPlanService: serviceContainer.mealPlanService,
                                                mealPlan: mealPlan)
        let router = MealPlanDateSelectionRouter(factory: self)
        let vc = MealPlanDateSelectionViewController(viewModel: vm)
        
        vm.router = router
        router.viewController = vc
        return vc
    }
    
    func makeMealPlanSelectionResultViewController() -> MealPlanSelectionResultViewController {
        let vm = MealPlanSelectionResultViewModel()
        let router = MealPlanSelectionResultRouter(factory: self)
        let vc = MealPlanSelectionResultViewController(viewModel: vm)
        
        vm.router = router
        router.viewController = vc
        return vc
    }
}

// MARK: - ViewModel Factory -

extension DependencyContainer {
    func makeIngredientViewModel(_ ingredientId: String?) -> IngredientViewModel {
        return IngredientViewModel(ingredientsService: serviceContainer.ingredientsService,
                                   ingredientId: ingredientId)
    }
    
    func makeIngredientsListViewModel() -> IngredientsListViewModel {
        return IngredientsListViewModel(ingredientsService: serviceContainer.ingredientsService)
    }
    
    func makeRecipeViewModel(_ recipeId: String) -> RecipeViewModel {
        return RecipeViewModel(recipesService: serviceContainer.recipesService,
                               recipeId: recipeId)
    }
    
    func makeRecipesListViewModel() -> RecipesListViewModel {
        return RecipesListViewModel(recipesService: serviceContainer.recipesService)
    }
    
    func makeTodayMenuViewModel() -> TodayMenuViewModel {
        return TodayMenuViewModel(mealPlanService: serviceContainer.mealPlanService)
    }
    
    func makeShoppingListViewModel() -> ShoppingListViewModel {
        return ShoppingListViewModel(shoppingListService: serviceContainer.shoppingListService)
    }
    
    func makeMealPlansListViewModel() -> MealPlansListViewModel {
        return MealPlansListViewModel(persistanceService: serviceContainer.persistenceService)
    }
    
    func makeMealPlanViewModel(mealPlan: MealPlan) -> MealPlanViewModel {
        return MealPlanViewModel(mealPlanService: serviceContainer.mealPlanService, mealPlan: mealPlan)
    }
    
    func makeMealPlanDateSelectionViewModel(mealPlanService: MealPlanServiceType, mealPlan: MealPlan) -> MealPlanDateSelectionViewModel {
        return MealPlanDateSelectionViewModel(mealPlanService: mealPlanService, mealPlan: mealPlan)
    }
}
