import Foundation

struct MealPlan {
    // MARK: - Properties
    var id: String
    var dailyPlans = [DailyPlan]()
    
    init(dailyPlans: [DailyPlan]) {
        self.id = UUID().uuidString
        self.dailyPlans = dailyPlans
    }
}

extension MealPlan: Persistable {
    init(managedObject: MealPlanObject) {
        self.id = managedObject.id
        self.dailyPlans = managedObject.dailyPlans.map { DailyPlan(managedObject: $0) }
    }
    
    var managedObject: MealPlanObject {
        return MealPlanObject(id: id, dailyPlans: dailyPlans.map { $0.managedObject })
    }
}
