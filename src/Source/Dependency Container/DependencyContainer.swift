import UIKit

class DependencyContainer {
    let serviceLocator: ServiceLocatorType
    var coordinator: SceneCoordinator!
    
    init(serviceLocator: ServiceLocatorType) {
        self.serviceLocator = serviceLocator
    }
}

extension DependencyContainer: ViewControllerFactory {
    func makeIngredientViewController(ingredientId: String?) -> IngredientViewController {
        let vm = makeIngredientViewModel(ingredientId)
        return IngredientViewController(viewModel: vm)
    }
    
    func makeIngredientsListViewController() -> IngredientsListViewController {
        let vm = makeIngredientsListViewModel()
        return IngredientsListViewController(viewModel: vm, coordinator: coordinator)
    }
    
    func makeNavigationController(rootViewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: rootViewController)
    }
}

// MARK: - ViewModelFactory -

extension DependencyContainer {
    func makeIngredientViewModel(_ ingredientId: String?) -> IngredientViewModel {
        return IngredientViewModel(coordinator: coordinator,
                                   ingredientsService: serviceLocator.ingredientsService,
                                   ingredientId: ingredientId)
    }
    
    func makeIngredientsListViewModel() -> IngredientsListViewModel {
        return IngredientsListViewModel(coordinator: coordinator,
                                        ingredientsService: serviceLocator.ingredientsService)
    }
}
