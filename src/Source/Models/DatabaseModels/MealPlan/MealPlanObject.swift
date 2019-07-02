import RealmSwift

@objcMembers
final class MealPlanObject: Object {
    // MARK: - Properties

    dynamic var id: String = ""
    dynamic var name: String = ""
    dynamic var image: String = ""
    let dailyPlans: List<DailyPlanObject> = List<DailyPlanObject>()

    // MARK: - Meta

    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: Convenience Init

    required convenience init(id: String, name: String, image: String, dailyPlans: [DailyPlanObject]) {
        self.init()
        self.id = id
        self.name = name
        self.image = image
        self.dailyPlans.append(objectsIn: dailyPlans)
    }
}
