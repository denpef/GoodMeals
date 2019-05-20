import RealmSwift

final class Recipe: Object {
    // MARK: - Properties
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    @objc dynamic var category: RecipeCategory?
    
    var ingredients: List<IngredientObject> = List<IngredientObject>()
    var calorific: Int = 0
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Convenience Init
    convenience required init(name: String,
                              ingredients: [IngredientObject] = [],
                              category: RecipeCategory? = nil) {
        self.init()
        self.name = name
        self.category = category
        self.ingredients.append(objectsIn: ingredients)
    }
}
