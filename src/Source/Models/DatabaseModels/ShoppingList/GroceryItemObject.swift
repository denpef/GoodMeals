import RealmSwift

@objcMembers
final class GroceryItemObject: Object {
    // MARK: - Properties

    dynamic var id: String = ""
    dynamic var ingredient: IngredientObject?
    dynamic var amount: Int = 0
    dynamic var marked: Bool = false

    // MARK: - Meta

    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: Convenience Init

    required convenience init(id: String, ingredient: IngredientObject?, amount: Int, marked: Bool) {
        self.init()
        self.id = id
        self.ingredient = ingredient
        self.amount = amount
        self.marked = marked
    }
}
