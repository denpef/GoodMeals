import RxCocoa
import RxSwift

class RecipeViewModel {
    /// Image url adress
    let image: Observable<String>
    
    /// Title of screen
    let title: Driver<String>
    
    /// Recipe info and action items (add to shopping list) plus list of ingredients
    let items: Driver<[RecipeSection]>
    
    /// Initial recipe value
    var recipe: Observable<Recipe>

    /// Count of serving for calculation ingredients amount
    let serving = BehaviorRelay<Int>(value: 2)
    
    /// Handle control action add all ingredients to shopping list
    let addToShoppingListAction = PublishRelay<Void>()

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let recipesService: RecipesServiceType
    private let shoppingListService: ShoppingListServiceType

    // MARK: - Init

    init(recipesService: RecipesServiceType, shoppingListService: ShoppingListServiceType, recipeId: String) {
        self.recipesService = recipesService
        self.shoppingListService = shoppingListService

        recipe = Observable.from(optional: recipesService.getModel(by: recipeId))

        image = recipe.map { $0.image }

        title = recipe.map { $0.name }.asDriver(onErrorJustReturn: "")

        items = recipe.map { recipe -> [RecipeSection] in
            var recipeItems = [RecipeItem]()
            recipeItems.append(.servingItem(calorific: recipe.calorific, timeForPreparing: recipe.timeForPreparing))
            recipe.ingredients.forEach {
                recipeItems.append(.ingredientItem(ingredient: $0))
            }
            return [RecipeSection(items: recipeItems)]
        }.asDriver(onErrorJustReturn: [])

        Observable.combineLatest(addToShoppingListAction, recipe, serving)
            .flatMapLatest { _, recipe, serving -> Observable<[GroceryItem]> in
                var items = [GroceryItem]()
                recipe.ingredients.forEach {
                    items.append(GroceryItem(ingredient: $0.ingredient,
                                             amount: $0.amount * serving,
                                             marked: false))
                }
                return Observable.from(optional: items)
            }.subscribe(onNext: { groceryItems in
                groceryItems.forEach {
                    self.shoppingListService.add($0)
                }
            }).disposed(by: disposeBag)
    }
}
