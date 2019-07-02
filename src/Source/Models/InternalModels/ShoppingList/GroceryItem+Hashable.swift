extension GroceryItem: Hashable {
    static func == (lhs: GroceryItem, rhs: GroceryItem) -> Bool {
        return lhs.id == rhs.id
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
