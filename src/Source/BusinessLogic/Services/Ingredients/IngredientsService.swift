import RealmSwift

// sourcery:begin: AutoMockable
protocol IngredientsServiceType {
    func add(_ ingredient: Ingredient)
    func subscribeCollection(subscriber: PersistenceNotificationOutput)
}

final class IngredientsService: IngredientsServiceType {
    private let persistenceService: PersistenceService
    var token: NotificationToken?

    init(persistenceService: PersistenceService) {
        self.persistenceService = persistenceService
    }

    func add(_ ingredient: Ingredient) {
        persistenceService.add(ingredient, update: false)
    }

    func subscribeCollection(subscriber: PersistenceNotificationOutput) {
        token = persistenceService.subscribeCollection(Ingredient.self,
                                                       subscriber: subscriber,
                                                       filter: nil,
                                                       sortDescriptors: nil)
    }
}
