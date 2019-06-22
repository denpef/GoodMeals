import Foundation
import RxCocoa
import RxSwift

final class ShoppingListViewModel {
    // MARK: - Input

    var markedItem = PublishRelay<GroceryItem>()
    var deleteItem = PublishRelay<GroceryItem>()
    var deleteAllList = PublishRelay<Void>()

    // MARK: - Output

    var items: BehaviorSubject<[GroceryItem]>

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let shoppingListService: ShoppingListServiceType

    // MARK: - Init

    init(shoppingListService: ShoppingListServiceType) {
        self.shoppingListService = shoppingListService

        items = BehaviorSubject(value: shoppingListService.all())

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
                let newItems = shoppingListService.all()
                items.onNext(newItems)
            default:
                break
            }
        }
    }
}
