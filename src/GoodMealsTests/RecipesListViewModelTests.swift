import RxCocoa
import RxSwift
import RxTest
import XCTest

@testable import GoodMeals

// swiftlint:disable implicitly_unwrapped_optional
class RecipesListViewModelTests: XCTestCase {
    var service: RecipesServiceTypeMock!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var router: RecipesListRouterTypeMock!

    var sut: RecipesListViewModel!

    // MARK: - Override test methods

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        service = RecipesServiceTypeMock()
        router = RecipesListRouterTypeMock()
        sut = RecipesListViewModel(recipesService: service, router: router)
    }

    override func tearDown() {
        sut = nil
        service = nil
        scheduler = nil
        router = nil
        disposeBag = nil
        super.tearDown()
    }

    // MARK: - Test functions

    func testFetchSelectedMealPlan() {
        let expectedItems: [Recipe] = [Recipe(name: "", image: "", timeForPreparing: "")]

        service.allReturnValue = expectedItems

        // create scheduler
        let items = scheduler.createObserver([Recipe].self)

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
