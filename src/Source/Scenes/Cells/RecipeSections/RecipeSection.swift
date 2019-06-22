import RxDataSources

struct RecipeSection: SectionModelType {
    var items: [RecipeItem]

    init(original: RecipeSection, items: [RecipeItem]) {
        self = original
        self.items = items
    }

    init(items: [RecipeItem]) {
        self.items = items
    }
}
