import RxCocoa
import RxSwift
import XCTest

@testable import GoodMeals

class RecipesListViewModelTests: XCTestCase {
    // MARK: - Properties

    let service = RecipesServiceTypeMock()
    let router = RecipesListRouterTypeMock()

    var sut: RecipesListViewModel?
    var recipe = Recipe(name: "Mock", image: "", timeForPreparing: "")

    // MARK: - Override test methods

    override func setUp() {
        recipe.id = "0"
        service.subscribeCollectionSubscriberCallsCount = 0
        service.allReturnValue = [recipe]
        sut = RecipesListViewModel(recipesService: service)
        sut?.router = router
        router.navigateToRecipeRecipeIdCallsCount = 0
    }

    // MARK: - test functions

    func testWhenInitialized() {
        XCTAssertNotNil(sut?.items, "items is nil by default")
        XCTAssertTrue(service.subscribeCollectionSubscriberCalled, "viewModel not subscribed on persistance updates")
        XCTAssertEqual(service.subscribeCollectionSubscriberCallsCount, 1)
    }

    func testSelectItem() {
        let selectItem = sut?.selectItem.asObserver()
        selectItem?.onNext(recipe)
        XCTAssertTrue(router.navigateToRecipeRecipeIdCalled, "routing is failed")
        XCTAssertEqual(router.navigateToRecipeRecipeIdCallsCount, 1, "routing is failed")
        XCTAssertEqual(router.navigateToRecipeRecipeIdReceivedRecipeId, recipe.id, "incorrect id when navigation is beginnig")
    }

    func testAddNewItem() {
        let addNewItem = sut?.addNewItem.asObserver()
        addNewItem?.onNext(())
        XCTAssertTrue(router.navigateToRecipeRecipeIdCalled, "routing is failed")
        XCTAssertEqual(router.navigateToRecipeRecipeIdCallsCount, 1, "routing is failed")
    }
}
