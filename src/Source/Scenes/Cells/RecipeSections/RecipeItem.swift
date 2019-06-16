import Foundation

enum RecipeItem {
    case RecipeInfoItem(calorific: Int, timeForPreparing: String)
    case IngredientItem(ingredient: IngredientAmount)
    //case ServingItem(count: Int)
}
