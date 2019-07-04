import RxCocoa
import RxSwift

class RecipesListViewModel {
    /// Call to open item page
    let selectItem = PublishSubject<Recipe>()

    /// Shopping list items (list of ingredients and amount)
    let items: Driver<[Recipe]>

    /// Signal to request item data source (such as when data source updates)
    let reload = PublishRelay<Void>()

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let recipesService: RecipesServiceType
    private let router: RecipesListRouterType

    // MARK: - Init

    init(recipesService: RecipesServiceType, router: RecipesListRouterType) {
        self.recipesService = recipesService
        self.router = router

        items = reload
            .flatMapLatest {
                Observable.from(optional: recipesService.all())
            }
            .asDriver(onErrorJustReturn: [])

        recipesService.subscribeCollection(subscriber: self)

        selectItem.subscribe(onNext: { [weak self] recipe in
            self?.router.navigateToRecipe(recipeId: recipe.id)
        }).disposed(by: disposeBag)
    }
}

extension RecipesListViewModel: PersistenceNotificationOutput {
    func didChanged<T>(_ changes: PersistenceNotification<T>) {
        if let changes = changes as? PersistenceNotification<Recipe> {
            switch changes {
            case .update:
                reload.accept(())
            default:
                break
            }
        }
    }
}
