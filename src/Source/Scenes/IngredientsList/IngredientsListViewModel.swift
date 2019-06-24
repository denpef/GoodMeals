import Foundation
import RxCocoa
import RxDataSources
import RxSwift

class IngredientsListViewModel {
    var router: IngredientsListRouterType?

    // MARK: - Input

    /// Call to show add new item screen
    let addNewItem = PublishSubject<Void>()

    /// Call to open item page
    let selectItem = PublishSubject<Ingredient>()

    // MARK: - Output

    var items: BehaviorSubject<[Ingredient]>

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let ingredientsService: IngredientsServiceType

    // MARK: - Init

    init(ingredientsService: IngredientsServiceType) {
        self.ingredientsService = ingredientsService

        items = BehaviorSubject(value: ingredientsService.all())

        ingredientsService.subscribeCollection(subscriber: self)

        selectItem.subscribe(onNext: { [weak self] ingredient in
            self?.router?.navigateToIngredient(ingredientId: ingredient.id)
        }).disposed(by: disposeBag)

        addNewItem
            .subscribe(onNext: { [weak self] in
                self?.router?.navigateToIngredient(ingredientId: nil)
            }).disposed(by: disposeBag)
    }
}

extension IngredientsListViewModel: PersistenceNotificationOutput {
    func didChanged<T>(_ changes: PersistenceNotification<T>) {
        if let changes = changes as? PersistenceNotification<Ingredient> {
            switch changes {
            case .initial, .update:
                items.on(.next(ingredientsService.all()))
            default:
                break
            }
        }
    }
}
