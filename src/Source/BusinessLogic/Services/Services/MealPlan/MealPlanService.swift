// sourcery:begin: AutoMockable
protocol MealPlanServiceType {
    func add(_ selectedMealPlan: SelectedMealPlan)
}

final class MealPlanService: MealPlanServiceType {
    private let persistenceService: PersistenceService
    
    init(persistenceService: PersistenceService) {
        self.persistenceService = persistenceService
    }
    
    func add(_ selectedMealPlan: SelectedMealPlan) {
        persistenceService.add(selectedMealPlan, update: true)
    }
}
