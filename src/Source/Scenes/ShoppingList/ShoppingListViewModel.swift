import Foundation
import RxSwift
import RxCocoa

final class ShoppingListViewModel {
    
    // MARK: - Input
    
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
    }
    
}

extension ShoppingListViewModel: PersistenceNotificationOutput {
    func didChanged<T>(_ changes: PersistenceNotification<T>) {
        if let changes = changes as? PersistenceNotification<Recipe> {
            switch changes {
            case let .error(error):
                break
            case let .initial(objects):
                items.on(.next(shoppingListService.all()))
            case let .update(objects, deletions, insertions, modifications):
                items.on(.next(shoppingListService.all()))
            }
        }
    }
}
