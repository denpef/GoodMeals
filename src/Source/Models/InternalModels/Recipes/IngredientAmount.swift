import Foundation

struct IngredientAmount: Equatable {
    /// Identificator
    var id: String
    
    /// Ingredient value
    var ingredient: Ingredient?
    
    /// Amount of mass (gramm)
    var amount: Int = 0

    // MARK: Init

    init(ingredient: Ingredient?, amount: Int) {
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
