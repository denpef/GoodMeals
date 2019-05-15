import Foundation
import RxSwift
import RealmSwift

protocol IngredientsServiceType {
    func add(new: Ingredient)
    func remove(_ ingredient: Ingredient)
    func replace(_ ingredient: Ingredient)
    func all() -> Observable<[Ingredient]>
}

final class IngredientsService: IngredientsServiceType {

    let persistenceService: RealmPersistenceService
    
    init(persistenceService: RealmPersistenceService) {
        self.persistenceService = persistenceService
    }
    
    func add(new: Ingredient) {
        
    }
    
    func remove(_ ingredient: Ingredient) {
        
    }
    
    func replace(_ ingredient: Ingredient) {
        
    }
    
    func all() -> Observable<[Ingredient]> {
//        let result = withRealm("getting tasks") { realm -> Observable<Results<Ingredient>> in
//            let realm = try Realm()
//            return realm.objects(Ingredient.self)
//        }
//        return result ?? .empty()
        return Observable.of([Ingredient(name: "Potato")])
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
