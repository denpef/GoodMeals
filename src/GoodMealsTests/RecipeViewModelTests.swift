import RxBlocking
import RxCocoa
import RxSwift
import RxTest
import XCTest

@testable import GoodMeals

class RecipeViewModelTests: XCTestCase {
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var recipeService: RecipesServiceType!
    var shoppingListService: ShoppingListServiceType!

    var expectedRecipe: Recipe!
    var expectedSections: [RecipeSection]!

    var sut: RecipeViewModel!

    // MARK: - Override test methods

    override func setUp() {
        super.setUp()

        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()

        let firstAmount = IngredientAmount(ingredient: Ingredient(name: "ingredient one"), amount: 30)
        let secondAmount = IngredientAmount(ingredient: Ingredient(name: "ingredient two"), amount: 50)
        expectedRecipe = Recipe(name: "Test recipe", image: "image", timeForPreparing: "timeForPreparing")
        expectedRecipe.ingredients = [firstAmount, secondAmount]

        let servingItem = RecipeItem.servingItem(calorific: expectedRecipe.calorific,
                                                 timeForPreparing: expectedRecipe.timeForPreparing)
        let firstItem = RecipeItem.ingredientItem(ingredient: firstAmount)
        let secondItem = RecipeItem.ingredientItem(ingredient: secondAmount)

        expectedSections = [RecipeSection(items: [servingItem, firstItem, secondItem])]

        let persistenceService = RealmPersistenceService(inMemoryIdentifier: "testFetchRecipe")
        persistenceService.clearAll()
        persistenceService.add(expectedRecipe)

        recipeService = RecipesService(persistenceService: persistenceService)
        shoppingListService = ShoppingListService(persistenceService: persistenceService)

        sut = RecipeViewModel(recipesService: recipeService,
                              shoppingListService: shoppingListService,
                              recipeId: expectedRecipe.id)
    }

    override func tearDown() {
        sut = nil
        shoppingListService = nil
        recipeService = nil
        scheduler = nil
        disposeBag = nil
        expectedRecipe = nil
        super.tearDown()
    }

    func testInitialRecipeValues() {
        XCTContext.runActivity(named: "image") { _ in
            do {
                let image = try sut.image.toBlocking().first()
                XCTAssertEqual(image, expectedRecipe.image)
            } catch {
                XCTFail("Image is empty")
            }
        }

        XCTContext.runActivity(named: "title") { _ in
            do {
                let title = try sut.title.toBlocking().first()
                XCTAssertEqual(title, expectedRecipe.name)
            } catch {
                XCTFail("Title item is empty")
            }
        }

        XCTContext.runActivity(named: "serving value") { _ in
            do {
                let serving = try sut.serving.toBlocking().first()
                XCTAssertEqual(serving, 2)
            } catch {
                XCTFail("Serving is empty")
            }
        }

        XCTContext.runActivity(named: "serving item") { _ in
            var sections: [RecipeSection]?
            do {
                sections = try sut.items.toBlocking().first()
            } catch {
                XCTFail("Recipe items are empty")
            }

            continueAfterFailure = false

            XCTAssertEqual(sections?.count, 1)

            guard let items = sections?.first?.items else {
                XCTFail("Sections are empty")
                return
            }

            guard let expextedItems = expectedSections.first?.items else {
                XCTFail("Expected items must not to be empty")
                return
            }

            for (index, item) in items.enumerated() {
                XCTAssertEqual(item, expextedItems[index])
            }

            continueAfterFailure = true
        }
    }
}
