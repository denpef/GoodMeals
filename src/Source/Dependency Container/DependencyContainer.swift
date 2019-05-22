import UIKit

class DependencyContainer {
    let serviceLocator: ServiceLocatorType
    
    init(serviceLocator: ServiceLocatorType) {
        self.serviceLocator = serviceLocator
    }
}

// MARK: - ViewController Factory -

extension DependencyContainer: ViewControllerFactory {
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
    
    func makeNavigationController(rootViewController: UIViewController) -> UINavigationController {
        return UINavigationController(rootViewController: rootViewController)
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
}
