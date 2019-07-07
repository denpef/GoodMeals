import RxBlocking
import RxCocoa
import RxSwift
import RxTest
import XCTest

@testable import GoodMeals

class GroceryCellViewModelTests: XCTestCase {
    var expectedIngredient = Ingredient(name: "Ingredient one")
    var sut: GroceryCellViewModel!
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        sut = GroceryCellViewModel()
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        scheduler = nil
        disposeBag = nil
    }

//    func testInitialMarkedValues() {
//        let expectedMarkedItem = GroceryItem(ingredient: expectedIngredient, amount: 380, marked: true)
//
//        // mock initial value
//        sut.shoppingItem.accept(expectedMarkedItem)
//
//        XCTAssertEqual(try sut?.amount.toBlocking().first(), expectedMarkedItem.amount.formattedMass)
//        XCTAssertEqual(try sut?.marked.toBlocking().first(), expectedMarkedItem.marked)
//        XCTAssertEqual(try sut?.title.toBlocking().first(), expectedIngredient.name)
//    }
//
//    func testInitialUnmarkedValues() {
//        let expectedUnmarkedItem = GroceryItem(ingredient: expectedIngredient, amount: 500, marked: false)
//
//        // mock initial value
//        sut.shoppingItem.accept(expectedUnmarkedItem)
//
//        XCTAssertEqual(try sut?.amount.toBlocking().first(), expectedUnmarkedItem.amount.formattedMass)
//        XCTAssertEqual(try sut?.marked.toBlocking().first(), expectedUnmarkedItem.marked)
//        XCTAssertEqual(try sut?.title.toBlocking().first(), expectedIngredient.name)
//    }

    func testMarkedValue() {
        let expectedMarkedItem = GroceryItem(ingredient: expectedIngredient, amount: 380, marked: true)
        let expectedUnmarkedItem = GroceryItem(ingredient: expectedIngredient, amount: 500, marked: false)

        // create scheduler
        let item = scheduler.createObserver(GroceryItem.self)
        let markedItem = scheduler.createObserver(GroceryItem.self)
        let deleteItem = scheduler.createObserver(GroceryItem.self)

        // bind the result
        sut.shoppingItem
            .bind(to: item)
            .disposed(by: disposeBag)

        sut.itemMarked
            .bind(to: markedItem)
            .disposed(by: disposeBag)

        sut.itemDeleted
            .bind(to: deleteItem)
            .disposed(by: disposeBag)

        // mock a reload
        scheduler.createColdObservable([.next(10, expectedMarkedItem),
                                        .next(40, expectedUnmarkedItem)])
            .bind(to: sut.shoppingItem)
            .disposed(by: disposeBag)

        // mock marked control action
        scheduler.createColdObservable([.next(15, ()),
                                        .next(20, ()),
                                        .next(45, ()),
                                        .next(60, ())])
            .bind(to: sut.markedAction)
            .disposed(by: disposeBag)

        // mock delete control action
        scheduler.createColdObservable([.next(25, ()),
                                        .next(30, ()),
                                        .next(35, ()),
                                        .next(70, ())])
            .bind(to: sut.deleteAction)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(item.events, [.next(10, expectedMarkedItem),
                                     .next(40, expectedUnmarkedItem)])

        XCTAssertEqual(markedItem.events, [.next(15, expectedMarkedItem),
                                           .next(20, expectedMarkedItem),
                                           .next(45, expectedUnmarkedItem),
                                           .next(60, expectedUnmarkedItem)])

        XCTAssertEqual(deleteItem.events, [.next(25, expectedMarkedItem),
                                           .next(30, expectedMarkedItem),
                                           .next(35, expectedMarkedItem),
                                           .next(70, expectedUnmarkedItem)])
    }
}
