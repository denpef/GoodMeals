import RealmSwift

@objcMembers final class IngredientCategoryObject: Object {
    // MARK: - Properties

    dynamic var id: String = ""
    dynamic var name: String = ""

    // MARK: - Meta

    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: Convenience Init

    required convenience init(id: String, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}
