import RealmSwift

@objcMembers
class MealObject: Object {
    dynamic var id: String = ""
    dynamic var mealtime: Int = 0
    dynamic var recipe: RecipeObject?

    // MARK: - Meta

    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: Convenience Init

    required convenience init(id: String, mealtime: Int, recipe: RecipeObject?) {
        self.init()
        self.id = id
        self.mealtime = mealtime
        self.recipe = recipe
    }
}
