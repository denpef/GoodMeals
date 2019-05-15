import RealmSwift

final class Ingredient: Object {
    // MARK: - Properties
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var calorific: Int = 0
    @objc dynamic var category: IngredientCategory?
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Convenience Init
    convenience required init(name: String, calorific: Int = 0, category: IngredientCategory? = nil) {
        self.init()
        self.name = name
        self.calorific = calorific
        self.category = category
    }
}
