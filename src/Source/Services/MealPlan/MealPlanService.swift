import RealmSwift

// sourcery:begin: AutoMockable
protocol MealPlanServiceType: AnyObject {
    func getCurrentMealPlan() -> SelectedMealPlan?
    func add(_ selectedMealPlan: SelectedMealPlan)
    func subscribeCollection(subscriber: PersistenceNotificationOutput)
    func all() -> [MealPlan]
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
        token = persistenceService.subscribeCollection(SelectedMealPlan.self,
                                                       subscriber: subscriber,
                                                       filter: nil,
                                                       sortDescriptors: nil)
    }

    func all() -> [MealPlan] {
        return persistenceService.objects(MealPlan.self, filter: nil, sortDescriptors: nil)
    }
}
