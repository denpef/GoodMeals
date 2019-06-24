import Foundation
import RxCocoa
import RxSwift

class RecipeViewModel {
    var recipe: Recipe

    // MARK: - Input

    let name: BehaviorRelay<String>
    let serving = BehaviorRelay<Int>(value: 2)
    let addToShoppingList = PublishRelay<Void>()
    let inShoppingList = BehaviorRelay<Bool>(value: false)
    let items: BehaviorSubject<[RecipeSection]>

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let recipesService: RecipesServiceType
    private let shoppingListService: ShoppingListServiceType

    // MARK: - Init

    init(recipesService: RecipesServiceType, shoppingListService: ShoppingListServiceType, recipeId: String) {
        self.recipesService = recipesService
        self.shoppingListService = shoppingListService
        recipe = recipesService.getModel(by: recipeId)!

        name = BehaviorRelay(value: recipe.name)

        var items = [RecipeItem]()
        items.append(.RecipeInfoItem(calorific: recipe.calorific, timeForPreparing: recipe.timeForPreparing))
        items.append(.ServingItem)
        recipe.ingredients.forEach {
            items.append(.IngredientItem(ingredient: $0))
        }
        self.items = BehaviorSubject(value: [RecipeSection(items: items)])

        addToShoppingList.subscribe(onNext: { [weak self] _ in
            guard let self = self else {
                return
            }
            self.recipe.ingredients.forEach {
                let item = GroceryItem(ingredient: $0.ingredient,
                                       amount: $0.amount * Float(self.serving.value),
                                       marked: false)
                self.shoppingListService.add(item)
            }
        }).disposed(by: disposeBag)
    }
}
