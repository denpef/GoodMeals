import Foundation
import RxSwift
import RealmSwift
import RxCocoa

protocol IngredientsServiceType {
    func getModel(by id: String) -> Ingredient?
    func add(_ ingredient: Ingredient)
    func remove(_ ingredient: Ingredient)
    func update(_ ingredient: Ingredient)
    func all() -> BehaviorSubject<[Ingredient]>
    func clearAll()
}

final class IngredientsService: IngredientsServiceType {

    let persistenceService: PersistenceService
    
    init(persistenceService: PersistenceService) {
        self.persistenceService = persistenceService
    }
    
    func getModel(by id: String) -> Ingredient? {
        let filter = NSPredicate(format: "id == %@", id)
        return persistenceService.objects(Ingredient.self,
                                   filter: filter,
                                   sortDescriptors: nil).first
    }
    
    func add(_ ingredient: Ingredient) {
        persistenceService.add(ingredient, update: false)
    }
    
    func remove(_ ingredient: Ingredient) {
        persistenceService.delete(ingredient)
    }
    
    func update(_ ingredient: Ingredient) {
        persistenceService.add(ingredient, update: true)
    }
    
    func all() -> BehaviorSubject<[Ingredient]> {
        let objects = persistenceService.objects(Ingredient.self,
                                                 filter: nil,
                                                 sortDescriptors: nil)
        return BehaviorSubject(value: objects)
    }
    
    func clearAll() {
        persistenceService.clearAll()
    }
}
