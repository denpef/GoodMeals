import RealmSwift

// sourcery:begin: AutoMockable
protocol RecipesServiceType {
    func getModel(by id: String) -> Recipe?
    func add(_ recipe: Recipe)
    func remove(_ recipe: Recipe)
    func update(_ recipe: Recipe)
    func all() -> [Recipe]
    func subscribeCollection(subscriber: PersistenceNotificationOutput)
    func clearAll()
}

final class RecipesService: RecipesServiceType {
    private let persistenceService: PersistenceService
    var token: NotificationToken?

    init(persistenceService: PersistenceService) {
        self.persistenceService = persistenceService
    }

    func getModel(by id: String) -> Recipe? {
        let filter = NSPredicate(format: "id == %@", id)
        return persistenceService.objects(Recipe.self,
                                          filter: filter,
                                          sortDescriptors: nil).first
    }

    func add(_ recipe: Recipe) {
        persistenceService.add(recipe, update: false)
    }

    func remove(_ recipe: Recipe) {
        persistenceService.delete(recipe)
    }

    func update(_ recipe: Recipe) {
        persistenceService.add(recipe, update: true)
    }

    func all() -> [Recipe] {
        let objects = persistenceService.objects(Recipe.self,
                                                 filter: nil,
                                                 sortDescriptors: nil)
        return objects
    }

    func subscribeCollection(subscriber: PersistenceNotificationOutput) {
        // TODO: - token invalidation
        token = persistenceService.subscribeCollection(Recipe.self,
                                                       subscriber: subscriber,
                                                       filter: nil,
                                                       sortDescriptors: nil)
    }

    func clearAll() {
        persistenceService.clearAll()
    }
}
