import XCTest
import RxSwift
import RxCocoa

@testable import GoodMeals

class IngredientsListViewModelTests: XCTestCase {

    // MARK: - Properties
    
    let service = IngredientsServiceTypeMock()
    let router = IngredientsListRouterTypeMock()
    
    var sut: IngredientsListViewModel?
    var ingredient = Ingredient(name: "Mock")

    // MARK: - Override test methods
    
    override func setUp() {
        ingredient.id = "0"
        service.subscribeCollectionSubscriberCallsCount = 0
        service.allReturnValue = [ingredient]
        sut = IngredientsListViewModel(ingredientsService: service)
        sut?.router = router
        router.navigateToIngredientIngredientIdCallsCount = 0
    }
    
    // MARK: - test functions
    
    func testWhenInitialized() {
        XCTAssertNotNil(sut?.items, "items is nil by default")
        XCTAssertTrue(service.subscribeCollectionSubscriberCalled, "viewModel not subscribed on persistance updates")
        XCTAssertEqual(service.subscribeCollectionSubscriberCallsCount, 1)
    }
    
    func testSelectItem() {
        let selectItem = sut?.selectItem.asObserver()
        selectItem?.onNext(ingredient)
        XCTAssertTrue(router.navigateToIngredientIngredientIdCalled, "routing is failed")
        XCTAssertEqual(router.navigateToIngredientIngredientIdCallsCount, 1, "routing is failed")
        XCTAssertEqual(router.navigateToIngredientIngredientIdReceivedIngredientId,
                       ingredient.id,
                       "incorrect id when navigation is beginnig")
    }
    
    func testAddNewItem() {
        let addNewItem = sut?.addNewItem.asObserver()
        addNewItem?.onNext(())
        XCTAssertTrue(router.navigateToIngredientIngredientIdCalled, "routing is failed")
        XCTAssertEqual(router.navigateToIngredientIngredientIdCallsCount, 1, "routing is failed")
    }
}
