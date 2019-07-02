import RxCocoa
import RxSwift

class MealPlanConfirmationViewModel {
    let mealPlan: MealPlan

    var router: MealPlanConfirmationRouterType?

    private let mealPlanService: MealPlanServiceType

    // MARK: - Input

    let accept = PublishRelay<Void>()

    // MARK: - Private properties

    private let disposeBag = DisposeBag()

    // MARK: - Init

    init(mealPlanService: MealPlanServiceType, mealPlan: MealPlan) {
        self.mealPlanService = mealPlanService
        self.mealPlan = mealPlan

        accept.subscribe(onNext: { [weak self] _ in
            self?.savePlan()
        }).disposed(by: disposeBag)
    }

    private func savePlan() {
        let selectedPlan = SelectedMealPlan(startDate: Date(), mealPlan: mealPlan)
        mealPlanService.add(selectedPlan)
        router?.dismiss()
    }
}
