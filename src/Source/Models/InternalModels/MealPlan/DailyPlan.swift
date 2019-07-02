import Foundation

struct DailyPlan {
    // MARK: - Properties

    var id: String
    var dayNumber: Int
    var meals = [Meal]()

    init(dayNumber: Int, meals: [Meal]) {
        id = UUID().uuidString
        self.dayNumber = dayNumber
        self.meals = meals
    }

    subscript(mealtime: Mealtime) -> Recipe? {
        return meals.first(where: { $0.mealtime == mealtime })?.recipe
    }
}

extension DailyPlan: Persistable {
    init(managedObject: DailyPlanObject) {
        id = managedObject.id
        dayNumber = managedObject.dayNumber
        meals = managedObject.meals.map { Meal(managedObject: $0) }
    }

    var managedObject: DailyPlanObject {
        return DailyPlanObject(id: id, dayNumber: dayNumber, meals: meals.map { $0.managedObject })
    }
}

extension DailyPlan: Equatable {
    static func == (lhs: DailyPlan, rhs: DailyPlan) -> Bool {
        return lhs.id == rhs.id
    }
}
