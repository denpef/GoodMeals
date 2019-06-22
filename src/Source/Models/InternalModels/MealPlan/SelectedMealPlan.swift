import Foundation

struct SelectedMealPlan {
    // MARK: - Properties

    var id: String
    var startDate: Date
    var mealPlan: MealPlan?

    var finishDate: Date {
        if
            let daysCount = mealPlan?.dailyPlans.count,
            let date = Calendar.current.date(bySetting: .day,
                                             value: daysCount,
                                             of: startDate) {
            return date
        } else {
            return startDate
        }
    }

    // MARK: Convenience Init

    init(startDate: Date, mealPlan: MealPlan?) {
        id = UUID().uuidString
        self.startDate = startDate
        self.mealPlan = mealPlan
    }
}

extension SelectedMealPlan: Persistable {
    init(managedObject: SelectedMealPlanObject) {
        id = managedObject.id
        startDate = managedObject.startDate
        if let mealPlanObject = managedObject.mealPlan {
            mealPlan = MealPlan(managedObject: mealPlanObject)
        }
    }

    var managedObject: SelectedMealPlanObject {
        return SelectedMealPlanObject(id: id, startDate: startDate,
                                      mealPlan: mealPlan?.managedObject)
    }
}
