import RxSwift
import RxTest
import XCTest

@testable import GoodMeals

class MealPlanViewModelTests: XCTestCase {
    var expectedPlan: MealPlan!
    var sut: MealPlanViewModel!
    var router: MealPlanRouterTypeMock!

    override func setUp() {
        super.setUp()

        let recipe = Recipe(name: "", image: "", timeForPreparing: "")
        let meal = Meal(mealtime: .breakfast, recipe: recipe)
        let dailyPlan = [DailyPlan(dayNumber: 1, meals: [meal])]
        expectedPlan = MealPlan(name: "", image: "", dailyPlans: dailyPlan)

        router = MealPlanRouterTypeMock()
        sut = MealPlanViewModel(mealPlan: expectedPlan, router: router)
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        expectedPlan = nil
        router = nil
    }

    func testSectionBuilding() {
        let scheduler = TestScheduler(initialClock: 0)
        let disposeBag = DisposeBag()
        let expectedSections = expectedPlan.makeSections

        // create scheduler
        let sections = scheduler.createObserver([MealPlanTableViewSection].self)

        sut.sections
            .bind(to: sections)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(sections.events, [.next(0, expectedSections), .completed(0)])
    }

    func testRecipeSelection() {
        let expectedRecipeId = "098123"
        XCTAssertFalse(router.navigateToRecipeRecipeIdCalled)
        sut.showRecipe.accept(expectedRecipeId)
        XCTAssert(router.navigateToRecipeRecipeIdCalled)
        XCTAssertEqual(router.navigateToRecipeRecipeIdReceivedRecipeId, expectedRecipeId)
    }

    func testMealPlanSelection() {
        XCTAssertFalse(router.navigateToConfirmationMealPlanCalled)
        sut.setMealPlanCurrent.accept(())
        XCTAssert(router.navigateToConfirmationMealPlanCalled)
    }
}
