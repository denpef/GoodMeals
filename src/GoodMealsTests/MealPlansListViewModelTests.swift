import RxBlocking
import RxSwift
import RxTest
import XCTest

@testable import GoodMeals

class MealPlansListViewModelTests: XCTestCase {
    var service: MealPlanServiceTypeMock!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!
    var router: MealPlansListRouterTypeMock!

    var sut: MealPlansListViewModel!

    // MARK: - Override test methods

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        service = MealPlanServiceTypeMock()
        router = MealPlansListRouterTypeMock()
        sut = MealPlansListViewModel(mealPlanService: service, router: router)
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

    func testFetchMealPlanList() {
        let recipe = Recipe(name: "", image: "", timeForPreparing: "")
        let meal = Meal(mealtime: .breakfast, recipe: recipe)
        let dailyPlan = [DailyPlan(dayNumber: 1, meals: [meal])]
        let expectedItems: [MealPlan] = [MealPlan(name: "", image: "", dailyPlans: dailyPlan)]

        service.allReturnValue = expectedItems

        // create scheduler
        let items = scheduler.createObserver([MealPlan].self)

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

    func testWithEmptyMealPlanList() {
        service.allReturnValue = []

        // create scheduler
        let items = scheduler.createObserver([MealPlan].self)

        sut.items
            .drive(items)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([.next(10, ())])
            .bind(to: sut.reload)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(items.events, [.next(10, [])])
    }

    func testMealPlan() {
        XCTAssertFalse(router.navigateToMealPlanMealPlanCalled)

        let recipe = Recipe(name: "", image: "", timeForPreparing: "")
        let meal = Meal(mealtime: .breakfast, recipe: recipe)
        let dailyPlan = [DailyPlan(dayNumber: 1, meals: [meal])]
        let expectedPlan = MealPlan(name: "", image: "", dailyPlans: dailyPlan)

        let action = scheduler.createObserver(MealPlan.self)

        sut.mealPlanDidSelect
            .bind(to: action)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([.next(10, expectedPlan),
                                        .next(20, expectedPlan),
                                        .next(30, expectedPlan)])
            .bind(to: sut.mealPlanDidSelect)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(action.events, [.next(10, expectedPlan),
                                       .next(20, expectedPlan),
                                       .next(30, expectedPlan)])
        XCTAssertTrue(router.navigateToMealPlanMealPlanCalled)
        XCTAssertEqual(router.navigateToMealPlanMealPlanReceivedMealPlan, expectedPlan)
        XCTAssertEqual(router.navigateToMealPlanMealPlanReceivedInvocations, [expectedPlan, expectedPlan, expectedPlan])
    }
}
