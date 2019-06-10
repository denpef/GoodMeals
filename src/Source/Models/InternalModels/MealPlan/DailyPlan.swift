import Foundation

struct DailyPlan {
    // MARK: - Properties
    var id: String
    var meals = [Meal]()
    
    init(meals: [Meal]) {
        self.id = UUID().uuidString
        self.meals = meals
    }
    
    subscript(mealtime: Mealtime) -> Recipe? {
        return meals.first(where: { $0.mealtime == mealtime })?.recipe
    }
}

extension DailyPlan: Persistable {
    init(managedObject: DailyPlanObject) {
        self.id = managedObject.id
        self.meals = managedObject.meals.map { Meal(managedObject: $0) }
    }
    
    var managedObject: DailyPlanObject {
        return DailyPlanObject(id: id, meals: meals.map { $0.managedObject })
    }
}

