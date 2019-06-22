import Foundation
import RxSwift

struct GroceryItem {
    // MARK: - Properties

    var id: String
    var ingredient: Ingredient?
    var amount: Float = 0
    var marked: Bool = false

    // MARK: Init

    init(ingredient: Ingredient?, amount: Float, marked: Bool) {
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

extension GroceryItem: Hashable {
    static func == (lhs: GroceryItem, _: GroceryItem) -> Bool {
        return lhs.id == lhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(amount)
        hasher.combine(marked)
        if let ingredient = self.ingredient {
            hasher.combine(ingredient.id.hashValue)
        }
    }
}
