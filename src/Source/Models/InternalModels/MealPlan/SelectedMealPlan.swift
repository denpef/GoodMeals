import Foundation

struct SelectedMealPlan {
    /// Identificator
    var id: String
    
    /// Start diet date
    var startDate: Date
    
    /// Details of daily plans
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

    var dailyPlansForToday: [DailyPlan] {
        guard let days = startDate.diffDaysFromToday, let plans = mealPlan?.dailyPlans else {
            return []
        }
        var filteredPlan = plans.filter { $0.dayNumber > days }
        filteredPlan.sort { $0.dayNumber < $1.dayNumber }
        return filteredPlan
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
        return SelectedMealPlanObject(id: id,
                                      startDate: startDate,
                                      mealPlan: mealPlan?.managedObject)
    }
}
