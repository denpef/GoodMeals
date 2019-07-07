import RxCocoa
import RxSwift
import RxTest
import XCTest

@testable import GoodMeals

class RecipesListViewModelTests: XCTestCase {
    var service: RecipesServiceTypeMock!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var router: RecipesListRouterTypeMock!

    let expectedRecipe = Recipe(name: "", image: "", timeForPreparing: "")

    var sut: RecipesListViewModel!

    // MARK: - Override test methods

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()

        service = RecipesServiceTypeMock()
        service.getModelByReturnValue = expectedRecipe

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

    func testFetchRecipeList() {
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

    func testWithEmptyRecipeList() {
        service.allReturnValue = []

        // create scheduler
        let items = scheduler.createObserver([Recipe].self)

        sut.items
            .drive(items)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([.next(10, ())])
            .bind(to: sut.reload)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(items.events, [.next(10, [])])
    }

    func testSelectItem() {
        XCTAssertFalse(router.navigateToRecipeRecipeIdCalled)

        let action = scheduler.createObserver(Recipe.self)

        sut.selectItem
            .bind(to: action)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([.next(10, expectedRecipe),
                                        .next(20, expectedRecipe),
                                        .next(30, expectedRecipe)])
            .bind(to: sut.selectItem)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(action.events, [.next(10, expectedRecipe),
                                       .next(20, expectedRecipe),
                                       .next(30, expectedRecipe)])
        XCTAssertTrue(router.navigateToRecipeRecipeIdCalled)
    }
}
