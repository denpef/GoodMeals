import Foundation

struct MealPlan {
    // MARK: - Properties
    var id: String
    var name: String
    var dailyPlans = [DailyPlan]()
    
    init(name: String, dailyPlans: [DailyPlan]) {
        self.id = UUID().uuidString
        self.name = name
        self.dailyPlans = dailyPlans
    }
}

extension MealPlan: Persistable {
    init(managedObject: MealPlanObject) {
        self.id = managedObject.id
        self.name = managedObject.name
        self.dailyPlans = managedObject.dailyPlans.map { DailyPlan(managedObject: $0) }
    }
    
    var managedObject: MealPlanObject {
        return MealPlanObject(id: id, name: name, dailyPlans: dailyPlans.map { $0.managedObject })
    }
}
