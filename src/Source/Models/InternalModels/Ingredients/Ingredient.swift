import Foundation

struct Ingredient {
    // MARK: - Properties

    var id: String
    var name: String = ""
    var calorific: Int = 0
    var category: IngredientCategory?

    // MARK: Init

    init(name: String, calorific: Int = 0, category: IngredientCategory? = nil) {
        id = UUID().uuidString
        self.name = name
        self.calorific = calorific
        self.category = category
    }
}

extension Ingredient: Persistable {
    init(managedObject: IngredientObject) {
        id = managedObject.id
        name = managedObject.name
        calorific = managedObject.calorific
        if let category = managedObject.category {
            self.category = IngredientCategory(managedObject: category)
        }
    }

    var managedObject: IngredientObject {
        return IngredientObject(id: id,
                                name: name,
                                calorific: calorific,
                                category: category?.managedObject)
    }
}
