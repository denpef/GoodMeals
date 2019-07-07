enum RecipeItem {
    case ingredientItem(ingredient: IngredientAmount)
    case servingItem(calorific: Int, timeForPreparing: String)
}

extension RecipeItem: Equatable {
    static func == (lhs: RecipeItem, rhs: RecipeItem) -> Bool {
        switch (lhs, rhs) {
        case let (.ingredientItem(ingredientLhs), .ingredientItem(ingredientRhs)):
            return ingredientLhs == ingredientRhs
        case (let .servingItem(calorificLhs, timeForPreparingLhs), let .servingItem(calorificRhs, timeForPreparingRhs)):
            return calorificLhs == calorificRhs && timeForPreparingLhs == timeForPreparingRhs
        default:
            return false
        }
    }
}
