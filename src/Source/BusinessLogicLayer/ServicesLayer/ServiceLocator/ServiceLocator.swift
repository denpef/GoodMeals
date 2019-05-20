import Foundation

protocol ServiceLocatorType {
    var ingredientsService: IngredientsServiceType { get }
}

final class ServiceLocator: ServiceLocatorType {
    var ingredientsService: IngredientsServiceType
    
    init() {
        let persistenceService = RealmPersistenceService.init(configuration: RealmDefaultConfiguration.config)
        self.ingredientsService = IngredientsService(persistenceService: persistenceService)
    }
}
