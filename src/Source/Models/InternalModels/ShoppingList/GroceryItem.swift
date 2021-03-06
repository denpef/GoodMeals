import Foundation

struct GroceryItem {
    /// Identificator
    var id: String

    /// Ingredien object
    var ingredient: Ingredient?

    /// Mass amount (gramm)
    var amount: Int = 0

    /// Sign of buy mark
    var marked: Bool = false

    // MARK: Init

    init(ingredient: Ingredient?, amount: Int, marked: Bool) {
        id = UUID().uuidString
        self.ingredient = ingredient
        self.amount = amount
        self.marked = marked
    }
}

extension GroceryItem: Persistable {
    init(managedObject: GroceryItemObject) {
        id = managedObject.id
        if let ingredient = managedObject.ingredient {
            self.ingredient = Ingredient(managedObject: ingredient)
        }
        amount = managedObject.amount
        marked = managedObject.marked
    }

    var managedObject: GroceryItemObject {
        return GroceryItemObject(id: id, ingredient: ingredient?.managedObject, amount: amount, marked: marked)
    }
}

extension GroceryItem: Equatable {
    static func == (lhs: GroceryItem, rhs: GroceryItem) -> Bool {
        return lhs.id == rhs.id
    }
}
