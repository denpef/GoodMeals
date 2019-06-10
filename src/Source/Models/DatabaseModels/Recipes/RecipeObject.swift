import RealmSwift

@objcMembers final class RecipeObject: Object {
    // MARK: - Properties
    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var image: String = ""
    var ingredients: List<IngredientObject> = List<IngredientObject>()
    
    dynamic var category: RecipeCategoryObject?
    
    dynamic var calorific: Int = 0
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Convenience Init
    convenience required init(id: String,
                              name: String,
                              image: String,
                              ingredients: [IngredientObject] = [],
                              category: RecipeCategoryObject? = nil,
                              calorific: Int) {
        self.init()
        self.id = id
        self.name = name
        self.image = image
        self.category = category
        self.ingredients.append(objectsIn: ingredients)
        self.calorific = calorific
    }
}
