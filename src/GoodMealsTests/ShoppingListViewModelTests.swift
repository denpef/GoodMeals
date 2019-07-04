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

    func testFetchShoppingList() {
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

    func testWithEmptyShoppingList() {
        service.allReturnValue = []

        // create scheduler
        let items = scheduler.createObserver([GroceryItem].self)

        sut.items
            .drive(items)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([.next(10, ())])
            .bind(to: sut.reload)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(items.events, [.next(10, [])])
    }

    func testMarkedItem() {
        XCTAssertFalse(service.markedCalled)

        let expectedItem = GroceryItem(ingredient: Ingredient(name: ""), amount: 0, marked: false)

        let action = scheduler.createObserver(GroceryItem.self)

        sut.markedItem
            .bind(to: action)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([.next(10, expectedItem),
                                        .next(20, expectedItem),
                                        .next(30, expectedItem)])
            .bind(to: sut.markedItem)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(action.events, [.next(10, expectedItem),
                                       .next(20, expectedItem),
                                       .next(30, expectedItem)])
        XCTAssertTrue(service.markedCalled)
    }

    func testDeleteItem() {
        XCTAssertFalse(service.deleteCalled)

        let expectedItem = GroceryItem(ingredient: Ingredient(name: ""), amount: 0, marked: false)

        let action = scheduler.createObserver(GroceryItem.self)

        sut.deleteItem
            .bind(to: action)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([.next(10, expectedItem),
                                        .next(20, expectedItem),
                                        .next(30, expectedItem)])
            .bind(to: sut.deleteItem)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(action.events, [.next(10, expectedItem),
                                       .next(20, expectedItem),
                                       .next(30, expectedItem)])
        XCTAssertTrue(service.deleteCalled)
    }

    func testDeleteAllList() {
        XCTAssertFalse(service.deleteAllListCalled)
        let action = scheduler.createObserver(Void.self)

        sut.deleteAllList
            .bind(to: action)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([.next(10, ())])
            .bind(to: sut.deleteAllList)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(action.events.count, 1)
        XCTAssertTrue(service.deleteAllListCalled)
    }
}
