import Foundation

protocol ServiceContainerType {
    var persistenceService: PersistenceService { get }
    var ingredientsService: IngredientsServiceType { get }
    var recipesService: RecipesServiceType { get }
    var mealPlanService: MealPlanServiceType { get }
    var shoppingListService: ShoppingListServiceType { get }
}

final class ServiceContainer: ServiceContainerType {
    let persistenceService: PersistenceService
    let ingredientsService: IngredientsServiceType
    let recipesService: RecipesServiceType
    let mealPlanService: MealPlanServiceType
    var shoppingListService: ShoppingListServiceType

    init() {
        persistenceService = RealmPersistenceService(configuration: RealmDefaultConfiguration.config)

        ingredientsService = IngredientsService(persistenceService: persistenceService)
        recipesService = RecipesService(persistenceService: persistenceService)
        mealPlanService = MealPlanService(persistenceService: persistenceService)
        shoppingListService = ShoppingListService(persistenceService: persistenceService)
    }
}
