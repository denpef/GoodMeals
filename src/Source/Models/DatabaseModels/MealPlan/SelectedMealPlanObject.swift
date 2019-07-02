import RealmSwift

@objcMembers
final class SelectedMealPlanObject: Object {
    // MARK: - Properties

    dynamic var id: String = ""
    dynamic var startDate = Date()
    dynamic var mealPlan: MealPlanObject?

    // MARK: - Meta

    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: Convenience Init

    required convenience init(id: String, startDate: Date, mealPlan: MealPlanObject?) {
        self.init()
        self.id = id
        self.startDate = startDate
        self.mealPlan = mealPlan
    }
}
