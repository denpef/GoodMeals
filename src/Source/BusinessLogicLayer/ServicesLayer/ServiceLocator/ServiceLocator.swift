import Foundation

protocol ServiceLocatorType {
    var ingredientsService: IngredientsServiceType { get }
    var recipesService: RecipesServiceType { get }
}

final class ServiceLocator: ServiceLocatorType {
    var ingredientsService: IngredientsServiceType
    var recipesService: RecipesServiceType
    
    init() {
        let persistenceService = RealmPersistenceService.init(configuration: RealmDefaultConfiguration.config)
        self.ingredientsService = IngredientsService(persistenceService: persistenceService)
        self.recipesService = RecipesService(persistenceService: persistenceService)
    }
}
