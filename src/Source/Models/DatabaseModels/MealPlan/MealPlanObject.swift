import RealmSwift

@objcMembers final class MealPlanObject: Object {
    // MARK: - Properties

    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var dailyPlans: List<DailyPlanObject> = List<DailyPlanObject>()

    // MARK: - Meta

    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: Convenience Init

    required convenience init(id: String, name: String, dailyPlans: [DailyPlanObject]) {
        self.init()
        self.id = id
        self.name = name
        self.dailyPlans.append(objectsIn: dailyPlans)
    }
}
