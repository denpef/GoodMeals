import UIKit

class DependencyContainer {
    let serviceLocator: ServiceLocatorType
    
    init(serviceLocator: ServiceLocatorType) {
        self.serviceLocator = serviceLocator
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
    
    func makeRecipeViewController(recipeId: String?) -> RecipeViewController {
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
}

// MARK: - ViewModel Factory -

extension DependencyContainer {
    func makeIngredientViewModel(_ ingredientId: String?) -> IngredientViewModel {
        return IngredientViewModel(ingredientsService: serviceLocator.ingredientsService,
                                   ingredientId: ingredientId)
    }
    
    func makeIngredientsListViewModel() -> IngredientsListViewModel {
        return IngredientsListViewModel(ingredientsService: serviceLocator.ingredientsService)
    }
    
    func makeRecipeViewModel(_ recipeId: String?) -> RecipeViewModel {
        return RecipeViewModel(recipesService: serviceLocator.recipesService,
                               recipeId: recipeId)
    }
    
    func makeRecipesListViewModel() -> RecipesListViewModel {
        return RecipesListViewModel(recipesService: serviceLocator.recipesService)
    }
    
    func makeTodayMenuViewModel() -> TodayMenuViewModel {
        return TodayMenuViewModel()
    }
    
    func makeShoppingListViewModel() -> ShoppingListViewModel {
        return ShoppingListViewModel()
    }
}
