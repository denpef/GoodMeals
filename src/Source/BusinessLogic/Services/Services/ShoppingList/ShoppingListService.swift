import Foundation
import RxSwift
import RealmSwift
import RxCocoa

// sourcery:begin: AutoMockable
protocol ShoppingListServiceType {
    func getModel(by id: String) -> GroceryItem?
    func add(_ groceryItem: GroceryItem)
    func remove(_ groceryItem: GroceryItem)
    func update(_ groceryItem: GroceryItem)
    func all() -> [GroceryItem]
    func subscribeCollection(subscriber: PersistenceNotificationOutput)
}

final class ShoppingListService: ShoppingListServiceType {
    
    private let persistenceService: PersistenceService
    var token: NotificationToken?
    
    init(persistenceService: PersistenceService) {
        self.persistenceService = persistenceService
    }
    
    func getModel(by id: String) -> GroceryItem? {
        let filter = NSPredicate(format: "id == %@", id)
        return persistenceService.objects(GroceryItem.self, filter: filter, sortDescriptors: nil).first
    }
    
    func add(_ groceryItem: GroceryItem) {
        persistenceService.add(groceryItem, update: false)
    }
    
    func remove(_ groceryItem: GroceryItem) {
        persistenceService.delete(groceryItem)
    }
    
    func update(_ groceryItem: GroceryItem) {
        persistenceService.add(groceryItem, update: true)
    }
    
    func all() -> [GroceryItem] {
        let objects = persistenceService.objects(GroceryItem.self, filter: nil, sortDescriptors: nil)
        return objects
    }
    
    func subscribeCollection(subscriber: PersistenceNotificationOutput) {
        // TODO: - token invalidation
        token = persistenceService.subscribeCollection(GroceryItem.self,
                                                       subscriber: subscriber,
                                                       filter: nil,
                                                       sortDescriptors: nil)
    }
}
