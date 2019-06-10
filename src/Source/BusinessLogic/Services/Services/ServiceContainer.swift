import Foundation

protocol ServiceContainerType {
    var persistenceService: PersistenceService { get }
    var ingredientsService: IngredientsServiceType { get }
    var recipesService: RecipesServiceType { get }
}

final class ServiceContainer: ServiceContainerType {
    var persistenceService: PersistenceService
    var ingredientsService: IngredientsServiceType
    var recipesService: RecipesServiceType
    
    init() {
        persistenceService = RealmPersistenceService.init(configuration: RealmDefaultConfiguration.config)
        ingredientsService = IngredientsService(persistenceService: persistenceService)
        recipesService = RecipesService(persistenceService: persistenceService)
    }
}
