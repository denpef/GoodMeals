import Foundation
import RxSwift
import RealmSwift
import RxCocoa

protocol IngredientsServiceType {
    func add(new: IngredientObject)
    func remove(_ ingredient: IngredientObject)
    func replace(_ ingredient: IngredientObject)
    func all() -> BehaviorRelay<[IngredientObject]>
}

final class IngredientsService: IngredientsServiceType {

    let persistenceService: PersistenceService
    
    init(persistenceService: PersistenceService) {
        self.persistenceService = persistenceService
    }
    
    func add(new: IngredientObject) {
        
    }
    
    func remove(_ ingredient: IngredientObject) {
        
    }
    
    func replace(_ ingredient: IngredientObject) {
        
    }
    
    func all() -> BehaviorRelay<[IngredientObject]> {
//        let result = withRealm("getting tasks") { realm -> Observable<Results<Ingredient>> in
//            let realm = try Realm()
//            return realm.objects(Ingredient.self)
//        }
//        return result ?? .empty()
        return BehaviorRelay(value: [IngredientObject(name: "Potato")])
    }
    
    private func withRealm<T>(_ operation: String, action: (Realm) throws -> T) -> T? {
        do {
            let realm = try Realm()
            return try action(realm)
        } catch let err {
            print("Failed \(operation) realm with error: \(err)")
            return nil
        }
    }
}
