import RxSwift
import RxTest
import XCTest

@testable import GoodMeals

class MealPlanConfirmationViewModelTests: XCTestCase {
    var expectedPlan = MealPlan(name: "Test plan", image: "", dailyPlans: [])
    var sut: MealPlanConfirmationViewModel!
    var router: MealPlanConfirmationRouterTypeMock!
    var mealPlanService: MealPlanServiceTypeMock!

    override func setUp() {
        super.setUp()
        router = MealPlanConfirmationRouterTypeMock()
        mealPlanService = MealPlanServiceTypeMock()
        sut = MealPlanConfirmationViewModel(mealPlanService: mealPlanService,
                                            mealPlan: expectedPlan,
                                            router: router)
    }

    override func tearDown() {
        super.tearDown()
        router = nil
        mealPlanService = nil
        sut = nil
    }

    func testSavePlan() {
        XCTAssertFalse(router.dismissCalled)
        XCTAssertFalse(mealPlanService.addCalled)
        sut.acceptAction.accept(())
        XCTAssert(router.dismissCalled)
        XCTAssert(mealPlanService.addCalled)
        XCTAssertEqual(mealPlanService.addReceivedSelectedMealPlan?.mealPlan, expectedPlan)
    }
}
