import RxCocoa
import RxSwift

/**
 Current meal plan module - show recipes by today
 */
final class TodayMenuViewModel {
    /// Handle meal plan action control event
    var mealPlansAction = PublishRelay<Void>()

    /// Action handle selection and navigate to any recipe from current plan
    var recipeSelected = PublishRelay<Recipe>()

    /// Current plan daily menu items
//    var items = BehaviorSubject<[DailyPlan]>(value: [])
    var items: Driver<[DailyPlan]>

    var reload = PublishRelay<Void>()

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private var router: TodayMenuRouterType
    private var mealPlanService: MealPlanServiceType

    // MARK: - Init

    init(mealPlanService: MealPlanServiceType, router: TodayMenuRouterType) {
        self.mealPlanService = mealPlanService
        self.router = router
        items = Observable.from([]).asDriver(onErrorJustReturn: [])

        mealPlanService.subscribeCollection(subscriber: self)

        mealPlansAction.subscribe(onNext: { _ in
            self.router.navigateToMealPlansList()
        }).disposed(by: disposeBag)

        recipeSelected.subscribe(onNext: { recipe in
            self.router.navigateToRecipe(recipeId: recipe.id)
        }).disposed(by: disposeBag)

        items = reload
            .flatMapLatest {
                Observable.from(optional: mealPlanService.getCurrentMealPlan()?.mealPlan?.dailyPlans)
            }.asDriver(onErrorJustReturn: [])
    }
}

extension TodayMenuViewModel: PersistenceNotificationOutput {
    func didChanged<T>(_ changes: PersistenceNotification<T>) {
        if let changes = changes as? PersistenceNotification<SelectedMealPlan> {
            switch changes {
            case .initial, .update:
                reload.accept(())
            default:
                break
            }
        }
    }
}
