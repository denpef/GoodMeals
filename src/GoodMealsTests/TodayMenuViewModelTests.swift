import RxBlocking
import RxSwift
import RxTest
import XCTest

@testable import GoodMeals

class TodayMenuViewModelTests: XCTestCase {
    var router: TodayMenuRouterTypeMock!
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
        let selectedPlan = SelectedMealPlan(startDate: Date(), mealPlan: mealPlan)

        let expectedPlans = selectedPlan.dailyPlansForToday

        service.getCurrentMealPlanReturnValue = selectedPlan

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

        XCTAssertEqual(plans.events, [.next(10, expectedPlans), .next(30, expectedPlans)])
    }

    func testWithEmptyDailyPlans() {
        service.getCurrentMealPlanReturnValue = nil

        // create scheduler
        let plans = scheduler.createObserver([DailyPlan].self)

        sut.items
            .drive(plans)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([.next(10, ())])
            .bind(to: sut.reload)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssert(plans.events.isEmpty)
    }

    func testMealPlansAction() {
        XCTAssertFalse(router.navigateToMealPlansListCalled)
        let action = scheduler.createObserver(Void.self)

        sut.mealPlansAction
            .bind(to: action)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([.next(10, ())])
            .bind(to: sut.mealPlansAction)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(action.events.count, 1)
        XCTAssertTrue(router.navigateToMealPlansListCalled)
    }

    func testRecipeSelected() {
        XCTAssertFalse(router.navigateToRecipeRecipeIdCalled)

        let expectedRecipe = Recipe(name: "", image: "", timeForPreparing: "")
        let expectedId = expectedRecipe.id

        let action = scheduler.createObserver(Recipe.self)

        sut.recipeSelected
            .bind(to: action)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([.next(10, expectedRecipe),
                                        .next(20, expectedRecipe),
                                        .next(30, expectedRecipe)])
            .bind(to: sut.recipeSelected)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(action.events, [.next(10, expectedRecipe),
                                       .next(20, expectedRecipe),
                                       .next(30, expectedRecipe)])
        XCTAssertTrue(router.navigateToRecipeRecipeIdCalled)
        XCTAssertEqual(router.navigateToRecipeRecipeIdReceivedRecipeId, expectedId)
        XCTAssertEqual(router.navigateToRecipeRecipeIdReceivedInvocations, [expectedId,
                                                                            expectedId,
                                                                            expectedId])
    }
}
