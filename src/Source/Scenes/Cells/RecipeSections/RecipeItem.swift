import Foundation

enum RecipeItem {
    case recipeInfoItem(calorific: Int, timeForPreparing: String)
    case ingredientItem(ingredient: IngredientAmount)
    case servingItem
}
