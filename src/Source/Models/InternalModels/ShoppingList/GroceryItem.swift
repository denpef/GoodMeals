import Foundation

struct GroceryItem {
    // MARK: - Properties
    
    var id: String
    var ingredient: Ingredient?
    var amount: Float = 0
    var marked: Bool = false
    
    // MARK: Init
    
    init(ingredient: Ingredient?, amount: Float, marked: Bool) {
        self.id = UUID().uuidString
        self.ingredient = ingredient
        self.amount = amount
        self.marked = marked
    }
}

extension GroceryItem: Persistable {
    init(managedObject: GroceryItemObject) {
        self.id = managedObject.id
        if let ingredient = managedObject.ingredient {
            self.ingredient = Ingredient(managedObject: ingredient)
        }
        self.amount = managedObject.amount
        self.marked = managedObject.marked
    }
    
    var managedObject: GroceryItemObject {
        return GroceryItemObject(id: id, ingredient: ingredient?.managedObject, amount: amount, marked: marked)
    }
}

extension GroceryItem: Hashable {
    static func == (lhs: GroceryItem, rhs: GroceryItem) -> Bool {
        return lhs.id == lhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
        hasher.combine(self.amount)
        hasher.combine(self.marked)
        if let ingredient = self.ingredient {
            hasher.combine(ingredient.id.hashValue)
        }
    }
}
