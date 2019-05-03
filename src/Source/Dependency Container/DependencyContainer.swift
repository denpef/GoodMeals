import Foundation

class DependencyContainer {}

extension DependencyContainer: ViewModelFactory {
    func makeRecipesListViewModel() -> RecipesListViewModel {
        return RecipesListViewModel(factory: self)
    }
}

extension DependencyContainer: ViewControllerFactory {
    func makeRecipesListViewController() -> RecipesListViewController {
        return RecipesListViewController(factory: self)
    }
}
