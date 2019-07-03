extension GroceryItem: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(amount)
        hasher.combine(marked)
        if let ingredient = self.ingredient {
            hasher.combine(ingredient.id.hashValue)
        }
    }
}
