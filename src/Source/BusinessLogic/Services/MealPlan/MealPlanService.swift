import RealmSwift

// sourcery:begin: AutoMockable
protocol MealPlanServiceType {
    func getCurrentMealPlan() -> SelectedMealPlan?
    func add(_ selectedMealPlan: SelectedMealPlan)
    func subscribeCollection(subscriber: PersistenceNotificationOutput)
}

final class MealPlanService: MealPlanServiceType {
    private let persistenceService: PersistenceService
    var token: NotificationToken?

    init(persistenceService: PersistenceService) {
        self.persistenceService = persistenceService
    }

    func add(_ selectedMealPlan: SelectedMealPlan) {
        persistenceService.add(selectedMealPlan, update: true)
    }

    func getCurrentMealPlan() -> SelectedMealPlan? {
        let filter = NSPredicate(format: #keyPath(SelectedMealPlanObject.startDate) + "<= %@", Date() as NSDate)
        let sortDescription = SortDescriptor(keyPath: #keyPath(SelectedMealPlanObject.startDate), ascending: false)
        let plans = persistenceService.objects(SelectedMealPlan.self, filter: filter, sortDescriptors: [sortDescription])
        return plans.first
    }

    func subscribeCollection(subscriber: PersistenceNotificationOutput) {
        // TODO: - token invalidation
        token = persistenceService.subscribeCollection(SelectedMealPlan.self,
                                                       subscriber: subscriber,
                                                       filter: nil,
                                                       sortDescriptors: nil)
    }
}
