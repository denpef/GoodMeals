class DependencyContainer {
    let serviceLocator: ServiceLocatorType
    
    init(serviceLocator: ServiceLocatorType) {
        self.serviceLocator = serviceLocator
    }
}

extension DependencyContainer: ViewModelFactory {
    func makeIngredientsListViewModel() -> IngredientsListViewModel {
        return IngredientsListViewModel(ingredientsService: serviceLocator.ingredientsService)
    }
}

extension DependencyContainer: ViewControllerFactory {
    func makeIngredientsListViewController() -> IngredientsListViewController {
        return IngredientsListViewController(factory: self)
    }
}
