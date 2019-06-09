import RealmSwift

@objcMembers final class MealPlanObject: Object {
    // MARK: - Properties
    dynamic var id: String = ""
    dynamic var dailyPlans: List<DailyPlanObject> = List<DailyPlanObject>()
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Convenience Init
    convenience required init(id: String, dailyPlans: [DailyPlanObject]) {
        self.init()
        self.id = id
        self.dailyPlans.append(objectsIn: dailyPlans)
    }
}
