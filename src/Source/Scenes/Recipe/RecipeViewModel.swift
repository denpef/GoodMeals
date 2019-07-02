import RxCocoa
import RxSwift

class RecipeViewModel {
    private var recipe: Recipe

    var image: String
    var title: String

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

        guard let recipe = recipesService.getModel(by: recipeId) else {
            fatalError("Can't get recipe from database by id: \(recipeId)")
        }

        self.recipe = recipe

        image = recipe.image
        title = recipe.name

        name = BehaviorRelay(value: recipe.name)

        var items = [RecipeItem]()
        items.append(.servingItem(calorific: recipe.calorific, timeForPreparing: recipe.timeForPreparing))
        recipe.ingredients.forEach {
            items.append(.ingredientItem(ingredient: $0))
        }
        self.items = BehaviorSubject(value: [RecipeSection(items: items)])

        addToShoppingList.subscribe(onNext: { [weak self] _ in
            guard let self = self else {
                return
            }
            self.recipe.ingredients.forEach {
                let item = GroceryItem(ingredient: $0.ingredient,
                                       amount: $0.amount * self.serving.value,
                                       marked: false)
                self.shoppingListService.add(item)
            }
        }).disposed(by: disposeBag)
    }
}
