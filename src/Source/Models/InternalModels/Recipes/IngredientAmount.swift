import Foundation

struct IngredientAmount {
    // MARK: - Properties

    var id: String
    var ingredient: Ingredient?
    var amount: Float = 0

    // MARK: Init

    init(ingredient: Ingredient?, amount: Float) {
        id = UUID().uuidString
        self.ingredient = ingredient
        self.amount = amount
    }
}

extension IngredientAmount: Persistable {
    init(managedObject: IngredientAmountObject) {
        id = managedObject.id
        if let ingredient = managedObject.ingredient {
            self.ingredient = Ingredient(managedObject: ingredient)
        }
        amount = managedObject.amount
    }

    var managedObject: IngredientAmountObject {
        return IngredientAmountObject(id: id, ingredient: ingredient?.managedObject, amount: amount)
    }
}
