import Foundation

enum RecipeItem {
    case ingredientItem(ingredient: IngredientAmount)
    case servingItem(calorific: Int, timeForPreparing: String)
}
