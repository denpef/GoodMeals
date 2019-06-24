import Foundation
import RxCocoa
import RxDataSources
import RxSwift

class RecipesListViewModel {
    var router: RecipesListRouterType?

    // MARK: - Input

    /// Call to show add new item screen
    let addNewItem = PublishSubject<Void>()

    /// Call to open item page
    let selectItem = PublishSubject<Recipe>()

    // MARK: - Output

    var items: BehaviorSubject<[Recipe]>

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let recipesService: RecipesServiceType

    // MARK: - Init

    init(recipesService: RecipesServiceType) {
        self.recipesService = recipesService

        items = BehaviorSubject(value: recipesService.all())

        recipesService.subscribeCollection(subscriber: self)

        selectItem.subscribe(onNext: { [weak self] recipe in
            self?.router?.navigateToRecipe(recipeId: recipe.id)
        }).disposed(by: disposeBag)
    }
}

extension RecipesListViewModel: PersistenceNotificationOutput {
    func didChanged<T>(_ changes: PersistenceNotification<T>) {
        if let changes = changes as? PersistenceNotification<Recipe> {
            switch changes {
            case .initial, .update:
                items.on(.next(recipesService.all()))
            default:
                break
            }
        }
    }
}
