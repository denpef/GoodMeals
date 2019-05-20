import RealmSwift

final class RecipeCategory: Object {
    // MARK: - Properties
    @objc dynamic var name: String = ""
    
    // MARK: Convenience Init
    convenience required init(name: String) {
        self.init()
        self.name = name
    }
}
