import Foundation
import RxSwift
import RealmSwift
import RxCocoa

// sourcery:begin: AutoMockable
protocol RecipesServiceType {
    func getModel(by id: String) -> Recipe?
    func add(_ Recipe: Recipe)
    func remove(_ Recipe: Recipe)
    func update(_ Recipe: Recipe)
    func all() -> [Recipe]
    func subscribeCollection(subscriber: PersistenceNotificationOutput)
    func clearAll()
}

final class RecipesService: RecipesServiceType {
    
    let persistenceService: PersistenceService
    var token: NotificationToken?
    
    init(persistenceService: PersistenceService) {
        self.persistenceService = persistenceService
    }
    
    func getModel(by id: String) -> Recipe? {
        let filter = NSPredicate(format: "id == %@", id)
        return persistenceService.objects(Recipe.self,
                                          filter: filter,
                                          sortDescriptors: nil).first
    }
    
    func add(_ Recipe: Recipe) {
        persistenceService.add(Recipe, update: false)
    }
    
    func remove(_ Recipe: Recipe) {
        persistenceService.delete(Recipe)
    }
    
    func update(_ Recipe: Recipe) {
        persistenceService.add(Recipe, update: true)
    }
    
    func all() -> [Recipe] {
        let objects = persistenceService.objects(Recipe.self,
                                                 filter: nil,
                                                 sortDescriptors: nil)
        return objects
    }
    
    func subscribeCollection(subscriber: PersistenceNotificationOutput) {
        // TODO: - token invalidation
        token = persistenceService.subscribeCollection(Recipe.self,
                                                       subscriber: subscriber,
                                                       filter: nil,
                                                       sortDescriptors: nil)
    }
    
    func clearAll() {
        persistenceService.clearAll()
    }
}
