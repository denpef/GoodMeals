import RxCocoa
import RxSwift

class MealPlanConfirmationViewModel {
    /// Title of shopping list screen
    let title: Driver<String>

    /// Plan's image
    let planImage: Driver<String>

    /// Handle confirmation action
    let acceptAction = PublishRelay<Void>()

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let router: MealPlanConfirmationRouterType
    private let mealPlanService: MealPlanServiceType

    // MARK: - Init

    init(mealPlanService: MealPlanServiceType, mealPlan: MealPlan, router: MealPlanConfirmationRouterType) {
        self.router = router
        self.mealPlanService = mealPlanService

        let savedPlan = Observable.of(mealPlan)

        planImage = savedPlan
            .map { $0.image }
            .asDriver(onErrorJustReturn: "")

        title = savedPlan
            .map { $0.name }
            .asDriver(onErrorJustReturn: "")

        acceptAction.withLatestFrom(savedPlan)
            .flatMapLatest { Observable.from(optional: $0) }
            .subscribe(onNext: { plan in
                self.mealPlanService.add(SelectedMealPlan(startDate: Date(), mealPlan: plan))
                self.router.dismiss()
            }).disposed(by: disposeBag)
    }
}
