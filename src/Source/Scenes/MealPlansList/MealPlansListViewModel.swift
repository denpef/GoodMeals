import RxCocoa
import RxSwift

/*
 Meal plans list screen logic
 */
final class MealPlansListViewModel {
    /// Handle selection meal plan item
    let mealPlanDidSelect = PublishSubject<MealPlan>()

    /// Meal plans to display on screen
    let items: Driver<[MealPlan]>

    /// Signal to request item data source (such as when data source updates)
    let reload = PublishRelay<Void>()

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let router: MealPlansListRouterType

    // MARK: - Init

    init(mealPlanService: MealPlanServiceType, router: MealPlansListRouterType) {
        self.router = router

        items = reload
            .flatMapLatest {
                Observable.from(optional: mealPlanService.all())
            }
            .asDriver(onErrorJustReturn: [])

        mealPlanDidSelect.subscribe(onNext: { [weak self] plan in
            self?.router.navigateToMealPlan(mealPlan: plan)
        }).disposed(by: disposeBag)
    }
}
