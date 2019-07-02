import RealmSwift

// sourcery:begin: AutoMockable
protocol ShoppingListServiceType {
    func getModel(by id: String) -> GroceryItem?
    func add(_ groceryItem: GroceryItem)
    func delete(_ groceryItem: GroceryItem)
    func update(_ groceryItem: GroceryItem)
    func all() -> [GroceryItem]
    func addByRecipe(_ recipe: Recipe)
    func addByRecipes(_ recipes: [Recipe])
    func subscribeCollection(subscriber: PersistenceNotificationOutput)
    func marked(_ item: GroceryItem)
    func deleteAllList()
}

final class ShoppingListService: ShoppingListServiceType {
    typealias Item = (ingredient: Ingredient, amount: Int)

    private let persistenceService: PersistenceService
    var token: NotificationToken?

    init(persistenceService: PersistenceService) {
        self.persistenceService = persistenceService
    }

    func getModel(by id: String) -> GroceryItem? {
        let filter = NSPredicate(format: "id == %@", id)
        return persistenceService.objects(GroceryItem.self, filter: filter, sortDescriptors: nil).first
    }

    func add(_ groceryItem: GroceryItem) {
        let allItems = all()
        if var item = allItems.first(where: { $0.ingredient == groceryItem.ingredient && !$0.marked }) {
            item.amount += groceryItem.amount
            update(item)
        } else {
            persistenceService.add(groceryItem, update: true)
        }
    }

    func delete(_ groceryItem: GroceryItem) {
        persistenceService.delete(groceryItem)
    }

    func update(_ groceryItem: GroceryItem) {
        persistenceService.add(groceryItem, update: true)
    }

    func addByRecipe(_ recipe: Recipe) {
        var groceryItems = [GroceryItem]()
        let allItems = all().filter { !$0.marked }
        recipe.ingredients.forEach { ingredientAmount in
            if var item = allItems.first(where: { $0.ingredient == ingredientAmount.ingredient }) {
                item.amount += ingredientAmount.amount
                groceryItems.append(item)
            } else {
                groceryItems.append(GroceryItem(ingredient: ingredientAmount.ingredient,
                                                amount: ingredientAmount.amount,
                                                marked: false))
            }
        }
        if !groceryItems.isEmpty {
            persistenceService.add(groceryItems, update: true)
        }
    }

    func addByRecipes(_ recipes: [Recipe]) {
        var items = [Item]()
        recipes.forEach { recipe in
            for amount in recipe.ingredients {
                guard let ingredient = amount.ingredient else {
                    continue
                }
                if var item = items.first(where: { $0.ingredient == ingredient }) {
                    item.amount += amount.amount
                    items.append(item)
                } else {
                    items.append(Item(ingredient, amount.amount))
                }
            }
        }

        var groceryItems = [GroceryItem]()
        let allItems = all().filter { !$0.marked }
        items.forEach { ingredientAmount in
            if var item = allItems.first(where: { $0.ingredient == ingredientAmount.ingredient }) {
                item.amount += ingredientAmount.amount
                groceryItems.append(item)
            } else {
                groceryItems.append(GroceryItem(ingredient: ingredientAmount.ingredient,
                                                amount: ingredientAmount.amount,
                                                marked: false))
            }
        }
        if !groceryItems.isEmpty {
            persistenceService.add(groceryItems, update: true)
        }
    }

    func all() -> [GroceryItem] {
        let sort = [SortDescriptor(keyPath: #keyPath(GroceryItemObject.marked), ascending: true),
                    SortDescriptor(keyPath: #keyPath(GroceryItemObject.ingredient.name), ascending: true)]
        return persistenceService.objects(GroceryItem.self, filter: nil, sortDescriptors: sort)
    }

    func subscribeCollection(subscriber: PersistenceNotificationOutput) {
        // TODO: - token invalidation
        token = persistenceService.subscribeCollection(GroceryItem.self,
                                                       subscriber: subscriber,
                                                       filter: nil,
                                                       sortDescriptors: nil)
    }

    func marked(_ item: GroceryItem) {
        var editableItem = item
        editableItem.marked = !item.marked
        update(editableItem)
    }

    func deleteAllList() {
        persistenceService.delete(type: GroceryItem.self)
    }
}
