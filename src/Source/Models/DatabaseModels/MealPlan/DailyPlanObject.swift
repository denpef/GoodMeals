import RealmSwift

@objcMembers final class DailyPlanObject: Object {
    // MARK: - Properties
    dynamic var id: String = ""
    dynamic var meals: List<MealObject> = List<MealObject>()
    
    // MARK: - Meta
    override static func primaryKey() -> String? {
        return "id"
    }
    
    // MARK: Convenience Init
    convenience required init(id: String, meals: [MealObject]) {
        self.init()
        self.id = id
        self.meals.append(objectsIn: meals)
    }
}
