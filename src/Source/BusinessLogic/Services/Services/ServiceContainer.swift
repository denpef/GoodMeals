import Foundation

protocol ServiceContainerType {
    var persistenceService: PersistenceService { get }
    var ingredientsService: IngredientsServiceType { get }
    var recipesService: RecipesServiceType { get }
    var mealPlanService: MealPlanServiceType { get }
}

final class ServiceContainer: ServiceContainerType {
    let persistenceService: PersistenceService
    let ingredientsService: IngredientsServiceType
    let recipesService: RecipesServiceType
    let mealPlanService: MealPlanServiceType
    
    init() {
        persistenceService = RealmPersistenceService.init(configuration: RealmDefaultConfiguration.config)
        
        ingredientsService = IngredientsService(persistenceService: persistenceService)
        recipesService = RecipesService(persistenceService: persistenceService)
        mealPlanService = MealPlanService(persistenceService: persistenceService)
    }
}
