protocol MealPlanServiceType {}

final class MealPlanService: MealPlanServiceType {
    private let persistenceService: PersistenceService
    
    init(persistenceService: PersistenceService) {
        self.persistenceService = persistenceService
    }
}
