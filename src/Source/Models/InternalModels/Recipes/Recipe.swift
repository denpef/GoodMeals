import Foundation

struct Recipe {
    // MARK: - Properties

    var id: String
    var ingredients = [IngredientAmount]()
    var name: String = ""
    var calorific: Int = 0
    var timeForPreparing: String = ""
    var category: RecipeCategory?
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
                            ingredients: ingredients.map { $0.managedObject },
                            category: category?.managedObject,
                            calorific: calorific)
    }
}
