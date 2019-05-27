import RealmSwift

@objcMembers final class IngredientObject: Object {
    // MARK: - Properties
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var calorific: Int = 0
    dynamic var category: IngredientCategoryObject?
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Convenience Init
    convenience required init(id: String,
                              name: String,
                              calorific: Int = 0,
                              category: IngredientCategoryObject? = nil) {
        self.init()
        self.id = id
        self.name = name
        self.calorific = calorific
        self.category = category
    }
}
