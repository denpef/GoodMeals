import RxDataSources

struct MealPlanTableViewSection: Equatable {
    var header: String
    var items: [Recipe]
}

extension MealPlanTableViewSection: SectionModelType {
    init(original: MealPlanTableViewSection, items: [Recipe]) {
        self = original
        self.items = items
    }
}
