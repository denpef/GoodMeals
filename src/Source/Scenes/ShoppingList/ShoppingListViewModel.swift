import RxCocoa
import RxSwift

/**
 Represent shopping list screen and related actions - remove, mark and clear
 */
final class ShoppingListViewModel {
    /// Handle the item mark action
    let markedItem = PublishRelay<GroceryItem>()

    /// Handle the item delete action
    let deleteItem = PublishRelay<GroceryItem>()

    /// Handle clear all shopping list action
    let deleteAllList = PublishRelay<Void>()

    /// Shopping list items (list of ingredients and amount)
    var items: Driver<[GroceryItem]>

    /// Signal to request item data source (such as when data source updates)
    let reload = PublishRelay<Void>()

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let shoppingListService: ShoppingListServiceType

    // MARK: - Init

    init(shoppingListService: ShoppingListServiceType) {
        self.shoppingListService = shoppingListService

        items = reload
            .flatMapLatest { Observable.from(optional: shoppingListService.all()) }
            .asDriver(onErrorJustReturn: [])

        shoppingListService.subscribeCollection(subscriber: self)

        markedItem.subscribe(onNext: { item in
            shoppingListService.marked(item)
        }).disposed(by: disposeBag)

        deleteItem.subscribe(onNext: { item in
            shoppingListService.delete(item)
        }).disposed(by: disposeBag)

        deleteAllList.subscribe(onNext: { _ in
            shoppingListService.deleteAllList()
        }).disposed(by: disposeBag)
    }
}

extension ShoppingListViewModel: PersistenceNotificationOutput {
    func didChanged<T>(_ changes: PersistenceNotification<T>) {
        if let changes = changes as? PersistenceNotification<GroceryItem> {
            switch changes {
            case .initial, .update:
                reload.accept(())
            default:
                break
            }
        }
    }
}
