import Foundation

enum Mealtime: Int {
    case breakfast, brunch, lunch, snack, dinner
}

struct Meal {
    var id: String
    var mealtime: Mealtime?
    var recipe: Recipe?

    init(mealtime: Mealtime?, recipe: Recipe?) {
        id = UUID().uuidString
        self.mealtime = mealtime
        self.recipe = recipe
    }
}

extension Meal: Persistable {
    init(managedObject: MealObject) {
        id = managedObject.id
        if let recipeObject = managedObject.recipe {
            recipe = Recipe(managedObject: recipeObject)
        }
        mealtime = Mealtime(rawValue: managedObject.mealtime)
    }

    var managedObject: MealObject {
        return MealObject(id: id, mealtime: mealtime?.rawValue ?? 0, recipe: recipe?.managedObject)
    }
}
