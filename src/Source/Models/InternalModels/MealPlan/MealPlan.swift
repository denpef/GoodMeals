import Foundation

struct MealPlan {
    /// Identificator
    var id: String
    
    /// Object name
    var name: String
    
    /// Details of meal plan by days
    var dailyPlans = [DailyPlan]()
    
    /// Title image adress
    var image: String

    init(name: String, image: String, dailyPlans: [DailyPlan]) {
        id = UUID().uuidString
        self.name = name
        self.image = image
        self.dailyPlans = dailyPlans
    }

    /// Sections to display plan details
    var makeSections: [MealPlanTableViewSection] {
        return dailyPlans.map { dailyPlan -> MealPlanTableViewSection in
            let items = dailyPlan.meals.compactMap { $0.recipe }
            return MealPlanTableViewSection(header: "Day \(dailyPlan.dayNumber)", items: items)
        }
    }
}

extension MealPlan: Persistable {
    init(managedObject: MealPlanObject) {
        id = managedObject.id
        name = managedObject.name
        image = managedObject.image
        dailyPlans = managedObject.dailyPlans.map { DailyPlan(managedObject: $0) }
    }

    var managedObject: MealPlanObject {
        return MealPlanObject(id: id, name: name, image: image, dailyPlans: dailyPlans.map { $0.managedObject })
    }
}

extension MealPlan: Equatable {
    static func == (lhs: MealPlan, rhs: MealPlan) -> Bool {
        return lhs.id == rhs.id
    }
}
