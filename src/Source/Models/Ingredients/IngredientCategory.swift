import RealmSwift

final class IngredientCategory: Object {
    // MARK: - Properties
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var name: String = ""
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Convenience Init
    convenience required init(name: String) {
        self.init()
        self.name = name
    }
}
