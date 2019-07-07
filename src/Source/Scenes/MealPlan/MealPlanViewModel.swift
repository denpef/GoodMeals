import RxCocoa
import RxSwift

/*
 Meal plan screen logic
 */
class MealPlanViewModel {
    /// Handle selection recipe from current meal plan
    let showRecipe = PublishRelay<String>()

    // Initial meal plan
    let mealPlan = PublishSubject<MealPlan>()

    // Screen title
    let title: Driver<String>

    // MARK: - Input

    let setMealPlanCurrent = PublishRelay<Void>()

    // MARK: - Output

    // Section represent daily recipes of selected plan
    let sections: Observable<[MealPlanTableViewSection]>

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let router: MealPlanRouterType

    // MARK: - Init

    init(mealPlan: MealPlan, router: MealPlanRouterType) {
        self.router = router

        title = self.mealPlan
            .map { $0.name }
            .asDriver(onErrorJustReturn: "")

        sections = self.mealPlan
            .flatMapLatest { plan -> Observable<[MealPlanTableViewSection]> in
                Observable.from(optional: plan.makeSections)
            }

        setMealPlanCurrent.withLatestFrom(self.mealPlan)
            .flatMapLatest { Observable.from(optional: $0) }
            .subscribe(onNext: { plan in
                self.router.navigateToConfirmation(mealPlan: plan)
            }).disposed(by: disposeBag)

        showRecipe.subscribe(onNext: { [weak self] recipeId in
            self?.router.navigateToRecipe(recipeId: recipeId)
        }).disposed(by: disposeBag)

        self.mealPlan.on(.next(mealPlan))
    }
}
