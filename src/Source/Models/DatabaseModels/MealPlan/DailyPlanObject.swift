import RealmSwift

@objcMembers
final class DailyPlanObject: Object {
    // MARK: - Properties

    dynamic var id: String = ""
    dynamic var dayNumber: Int = 0
    let meals: List<MealObject> = List<MealObject>()

    // MARK: - Meta

    override static func primaryKey() -> String? {
        return "id"
    }

    // MARK: Convenience Init

    required convenience init(id: String, dayNumber: Int, meals: [MealObject]) {
        self.init()
        self.id = id
        self.dayNumber = dayNumber
        self.meals.append(objectsIn: meals)
    }
}
