import RxBlocking
import RxSwift
import RxTest
import XCTest

@testable import GoodMeals

// swiftlint:disable implicitly_unwrapped_optional
class TodayMenuViewModelTests: XCTestCase {
    var router: TodayMenuRouterType!
    var service: MealPlanServiceTypeMock!
    var scheduler: TestScheduler!
    var disposeBag: DisposeBag!

    var sut: TodayMenuViewModel!

    // MARK: - Override test methods

    override func setUp() {
        super.setUp()
        scheduler = TestScheduler(initialClock: 0)
        disposeBag = DisposeBag()
        service = MealPlanServiceTypeMock()
        router = TodayMenuRouterTypeMock()
        sut = TodayMenuViewModel(mealPlanService: service, router: router)
    }

    override func tearDown() {
        sut = nil
        service = nil
        router = nil
        scheduler = nil
        disposeBag = nil
        super.tearDown()
    }

    // MARK: - Test functions

    func testFetchSelectedMealPlan() {
        let recipe = Recipe(name: "", image: "", timeForPreparing: "")
        let meal = Meal(mealtime: .breakfast, recipe: recipe)
        let dailyPlans: [DailyPlan] = [DailyPlan(dayNumber: 1, meals: [meal])]
        let mealPlan = MealPlan(name: "", image: "", dailyPlans: dailyPlans)
        let expectedPlan = SelectedMealPlan(startDate: Date(), mealPlan: mealPlan)

        service.getCurrentMealPlanReturnValue = expectedPlan

        // create scheduler
        let plans = scheduler.createObserver([DailyPlan].self)

        // bind the result
        sut.items
            .drive(plans)
            .disposed(by: disposeBag)

        // mock a reload
        scheduler.createColdObservable([.next(10, ()), .next(30, ())])
            .bind(to: sut.reload)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(plans.events, [.next(10, dailyPlans), .next(30, dailyPlans)])
    }
}
