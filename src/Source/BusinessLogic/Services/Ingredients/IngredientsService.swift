import RealmSwift

// sourcery:begin: AutoMockable
protocol IngredientsServiceType {
    func getModel(by id: String) -> Ingredient?
    func add(_ ingredient: Ingredient)
    func remove(_ ingredient: Ingredient)
    func update(_ ingredient: Ingredient)
    func all() -> [Ingredient]
    func subscribeCollection(subscriber: PersistenceNotificationOutput)
    func clearAll()
}

final class IngredientsService: IngredientsServiceType {
    private let persistenceService: PersistenceService
    var token: NotificationToken?

    init(persistenceService: PersistenceService) {
        self.persistenceService = persistenceService
    }

    func getModel(by id: String) -> Ingredient? {
        let filter = NSPredicate(format: "id == %@", id)
        return persistenceService.objects(Ingredient.self,
                                          filter: filter,
                                          sortDescriptors: nil).first
    }

    func add(_ ingredient: Ingredient) {
        persistenceService.add(ingredient, update: false)
    }

    func remove(_ ingredient: Ingredient) {
        persistenceService.delete(ingredient)
    }

    func update(_ ingredient: Ingredient) {
        persistenceService.add(ingredient, update: true)
    }

    func all() -> [Ingredient] {
        let objects = persistenceService.objects(Ingredient.self,
                                                 filter: nil,
                                                 sortDescriptors: nil)
        return objects
    }

    func subscribeCollection(subscriber: PersistenceNotificationOutput) {
        // TODO: - token invalidation
        token = persistenceService.subscribeCollection(Ingredient.self,
                                                       subscriber: subscriber,
                                                       filter: nil,
                                                       sortDescriptors: nil)
    }

    func clearAll() {
        persistenceService.clearAll()
    }
}
