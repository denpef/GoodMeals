import Foundation
import RxSwift
import RealmSwift
import RxCocoa

protocol IngredientsServiceType {
    func add(_ ingredient: Ingredient)
    func remove(_ ingredient: Ingredient)
    func update(_ ingredient: Ingredient)
    func all() -> BehaviorRelay<[Ingredient]>
    func clearAll()
}

final class IngredientsService: IngredientsServiceType {

    let persistenceService: PersistenceService
    
    init(persistenceService: PersistenceService) {
        self.persistenceService = persistenceService
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
    
    func all() -> BehaviorRelay<[Ingredient]> {
        let objects = persistenceService.objects(Ingredient.self,
                                                 filter: nil,
                                                 sortDescriptors: nil)
        return BehaviorRelay(value: objects)
    }
    
    func clearAll() {
        persistenceService.clearAll()
    }
}
