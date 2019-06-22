import RealmSwift

@objcMembers final class IngredientAmountObject: Object {
    // MARK: - Properties

    dynamic var id: String = ""
    dynamic var ingredient: IngredientObject?
    dynamic var amount: Float = 0

    // MARK: - Meta

    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: Convenience Init

    required convenience init(id: String, ingredient: IngredientObject?, amount: Float) {
        self.init()
        self.id = id
        self.ingredient = ingredient
        self.amount = amount
    }
}
