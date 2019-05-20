import RealmSwift

final class IngredientObject: Object {
    // MARK: - Properties
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var calorific: Int = 0
    @objc dynamic var category: IngredientCategoryObject?
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Convenience Init
    convenience required init(name: String, calorific: Int = 0, category: IngredientCategoryObject? = nil) {
        self.init()
        self.name = name
        self.calorific = calorific
        self.category = category
    }
}

//extension IngredientObject: DatabaseObject {
//    var internalModel: Ingredient {
//        return Ingredient(name: name, calorific: calorific, category: category?.internalModel)
//    }
//}
