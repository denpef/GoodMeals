import Foundation

struct Recipe {
    /// Identificator
    var id: String

    /// List of using ingredients
    var ingredients = [IngredientAmount]()

    /// Object name
    var name: String = ""

    /// Recipe calorific info (kcal)
    var calorific: Int = 0

    /// Recipe time for prepearing
    var timeForPreparing: String = ""

    /// Category of recip (not implemented for now)
    var category: RecipeCategory?

    /// Recipe title image
    var image: String = ""

    // MARK: Init

    init(name: String, image: String, timeForPreparing: String, calorific: Int = 0, category: RecipeCategory? = nil) {
        id = UUID().uuidString
        self.name = name
        self.image = image
        self.timeForPreparing = timeForPreparing
        self.calorific = calorific
        self.category = category
    }
}

extension Recipe: Persistable {
    init(managedObject: RecipeObject) {
        id = managedObject.id
        name = managedObject.name
        image = managedObject.image
        timeForPreparing = managedObject.timeForPreparing
        ingredients = managedObject.ingredients.map { IngredientAmount(managedObject: $0) }
        calorific = managedObject.calorific
        if let category = managedObject.category {
            self.category = RecipeCategory(managedObject: category)
        }
    }

    var managedObject: RecipeObject {
        return RecipeObject(id: id,
                            name: name,
                            image: image,
                            timeForPreparing: timeForPreparing,
                            calorific: calorific,
                            ingredients: ingredients.map { $0.managedObject },
                            category: category?.managedObject)
    }
}

extension Recipe: Equatable {
    static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return lhs.id == rhs.id
    }
}
