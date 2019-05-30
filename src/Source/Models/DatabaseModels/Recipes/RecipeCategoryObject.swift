import RealmSwift

@objcMembers final class RecipeCategoryObject: Object {
    // MARK: - Properties
    dynamic var id: String = ""
    dynamic var name: String = ""
    
    // MARK: Convenience Init
    convenience required init(id: String, name: String) {
        self.init()
        self.id = id
        self.name = name
    }
}
