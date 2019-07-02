import RxSwift
// import RxTest
import XCTest

@testable import GoodMeals

class TodayMenuViewModelTests: XCTestCase {
    let router = TodayMenuRouterTypeMock()
    let service = MealPlanServiceTypeMock()

    var sut: TodayMenuViewModel?

    // MARK: - Override test methods

    override func setUp() {
        super.setUp()
        sut = TodayMenuViewModel(mealPlanService: service, router: router)
    }

    // MARK: - Test functions

    func testWhenInitialized() {
        XCTAssertNotNil(sut?.items, "items is nil by default")
        XCTAssertTrue(service.subscribeCollectionSubscriberCalled, "viewModel not subscribed on persistance updates")
        XCTAssertEqual(service.subscribeCollectionSubscriberCallsCount, 1)
    }

    func testSelectItem() {
        var recipe = Recipe(name: "Mock", image: "", timeForPreparing: "")
        sut?.recipeSelected.asObser().onNext(recipe)
        XCTAssertTrue(router.navigateToRecipeRecipeIdCalled, "routing is failed")
        XCTAssertEqual(router.navigateToRecipeRecipeIdCallsCount, 1, "routing is failed")
        XCTAssertEqual(router.navigateToRecipeRecipeIdReceivedRecipeId, recipe.id, "incorrect id when navigation is beginnig")
    }
}
