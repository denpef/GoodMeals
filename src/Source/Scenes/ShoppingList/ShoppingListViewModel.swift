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
