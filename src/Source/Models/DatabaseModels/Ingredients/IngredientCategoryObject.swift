import RealmSwift

final class IngredientCategoryObject: Object {
    // MARK: - Properties
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Convenience Init
    convenience required init(id: String, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}
