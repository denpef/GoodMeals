import RealmSwift

@objcMembers final class RecipeObject: Object {
    // MARK: - Properties

    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var image: String = ""
    dynamic var timeForPreparing: String = ""
    var ingredients: List<IngredientAmountObject> = List<IngredientAmountObject>()

    dynamic var category: RecipeCategoryObject?

    dynamic var calorific: Int = 0

    // MARK: - Meta

    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: Convenience Init

    required convenience init(id: String,
                              name: String,
                              image: String,
                              timeForPreparing: String,
                              calorific: Int,
                              ingredients: [IngredientAmountObject] = [],
                              category: RecipeCategoryObject? = nil) {
        self.init()
        self.id = id
        self.name = name
        self.image = image
        self.timeForPreparing = timeForPreparing
        self.category = category
        self.ingredients.append(objectsIn: ingredients)
        self.calorific = calorific
    }
}
