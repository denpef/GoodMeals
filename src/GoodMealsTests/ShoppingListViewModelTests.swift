import RxBlocking
import RxSwift
import RxTest
import XCTest

@testable import GoodMeals

// swiftlint:disable implicitly_unwrapped_optional
class ShoppingListViewModelTests: XCTestCase {
    var service: ShoppingListServiceTypeMock!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    var sut: ShoppingListViewModel!

    // MARK: - Override test methods

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        service = ShoppingListServiceTypeMock()
        sut = ShoppingListViewModel(shoppingListService: service)
    }

    override func tearDown() {
        sut = nil
        service = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }

    // MARK: - Test functions

    func testFetchSelectedMealPlan() {
        let ingredient = Ingredient(name: "")
        let expectedItems: [GroceryItem] = [GroceryItem(ingredient: ingredient, amount: 0, marked: false)]

        service.allReturnValue = expectedItems

        // create scheduler
        let items = scheduler.createObserver([GroceryItem].self)

        // bind the result
        sut.items
            .drive(items)
            .disposed(by: disposeBag)

        // mock a reload
        scheduler.createColdObservable([.next(15, ()), .next(20, ())])
            .bind(to: sut.reload)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(items.events, [.next(15, expectedItems), .next(20, expectedItems)])
    }
}
