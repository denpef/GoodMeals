import Foundation

struct MealPlan {
    // MARK: - Properties

    var id: String
    var name: String
    var dailyPlans = [DailyPlan]()
    var image: String

    init(name: String, image: String, dailyPlans: [DailyPlan]) {
        id = UUID().uuidString
        self.name = name
        self.image = image
        self.dailyPlans = dailyPlans
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
