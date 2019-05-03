import Foundation
import RealmSwift

struct FetchRequest<Model, RealmObject: Object> {
    let predicate: NSPredicate?
    let sortDescriptors: [SortDescriptor]
    let transformer: (Results<RealmObject>) -> Model
}

final class IngredientCategoryObject: Object {
    @objc dynamic var categoryID: String = UUID().uuidString
    @objc dynamic var name: String = ""
    
    override static func primaryKey() -> String? {
        return "categoryID"
    }
}

extension IngredientCategoryObject {
    convenience init(ingredientCategory: IngredientCategory) {
        self.init()
        
        if !ingredientCategory.categoryID.isEmpty {
            self.categoryID = ingredientCategory.categoryID
        }
        
        self.name = ingredientCategory.name
    }
}

final class IngredientObject: Object {
    @objc dynamic var ingredientID: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var calorific: Int = 0
    @objc dynamic var category: String = ""

    override static func primaryKey() -> String? {
        return "ingredientID"
    }
}

extension IngredientObject {
    convenience init(ingredient: Ingredient) {
        self.init()
        
        if !ingredient.ingredientID.isEmpty {
            self.ingredientID = ingredient.ingredientID
        }
        
        self.name = ingredient.name
        self.calorific = ingredient.calorific
        self.category = ingredient.category
    }
}

extension Ingredient {
    static let all = FetchRequest<[Ingredient], IngredientObject>(predicate: nil,
                                                                  sortDescriptors: [SortDescriptor.name],
                                                                  transformer: {
                                                                    $0.map(Ingredient.init)
                                                                    
    })
}

final class RealmPersistenceService {
    private let realm: Realm
    
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }
    
    func createOrUpdate<Model, RealmObject: Object>(model: Model, with reverseTransformer: (Model) -> RealmObject) {
        let object = reverseTransformer(model)
        try! realm.write {
            realm.add(object, update: true)
        }
    }
    
    func fetch<Model, RealmObject>(with request: FetchRequest<Model, RealmObject>) -> Model {
        var results = realm.objects(RealmObject.self)
        
        if let predicate = request.predicate {
            results = results.filter(predicate)
        }
        
        if request.sortDescriptors.count > 0 {
            results = results.sorted(by: request.sortDescriptors)
        }
        
        return request.transformer(results)
    }
    
    func delete<RealmObject: Object>(type: RealmObject.Type, with primaryKey: String) {
        let object = realm.object(ofType: type, forPrimaryKey: primaryKey)
        if let object = object {
            try! realm.write {
                realm.delete(object)
            }
        }
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
}
