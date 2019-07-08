import Foundation

struct IngredientCategory {
    /// Identificator
    var id: String
    
    /// Object name
    var name: String = ""

    // MARK: Convenience Init

    init(name: String) {
        id = UUID().uuidString
        self.name = name
    }
}

extension IngredientCategory: Persistable {
    init(managedObject: IngredientCategoryObject) {
        id = managedObject.id
        name = managedObject.name
    }

    var managedObject: IngredientCategoryObject {
        return IngredientCategoryObject(id: id, name: name)
    }
}
