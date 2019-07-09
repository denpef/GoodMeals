import RxCocoa
import RxSwift

/**
 Current meal plan module - show recipes by today
 */
final class TodayMenuViewModel {
    /// Title of today meal plan screen
    let title: Driver<String>

    /// Handle meal plan action control event
    let mealPlansAction = PublishRelay<Void>()

    /// Action handle selection and navigate to any recipe from current plan
    let recipeSelected = PublishRelay<Recipe>()

    /// Current plan daily menu items
    let items: Driver<[DailyPlan]>

    /// Signal to request item data source (such as when data source updates)
    let reload = PublishRelay<Void>()

    // MARK: - Private properties

    private weak var mealPlanService: MealPlanServiceType?

    private let disposeBag = DisposeBag()
    private var router: TodayMenuRouterType

    // MARK: - Init

    init(mealPlanService: MealPlanServiceType?, router: TodayMenuRouterType) {
        self.mealPlanService = mealPlanService
        self.router = router

        let plan = reload
            .flatMapLatest {
                Observable.from(optional: mealPlanService?.getCurrentMealPlan())
            }

        items = plan
            .flatMapLatest { plan -> Observable<[DailyPlan]> in
                Observable.from(optional: plan.dailyPlansForToday)
            }.asDriver(onErrorJustReturn: [])

        title = plan
            .map { $0.mealPlan?.name ?? "" }
            .asDriver(onErrorJustReturn: "")

        mealPlanService?.subscribeCollection(subscriber: self)

        mealPlansAction.subscribe(onNext: { _ in
            self.router.navigateToMealPlansList()
        }).disposed(by: disposeBag)

        recipeSelected.subscribe(onNext: { recipe in
            self.router.navigateToRecipe(recipeId: recipe.id)
        }).disposed(by: disposeBag)
    }
}

extension TodayMenuViewModel: PersistenceNotificationOutput {
    func didChanged<T>(_ changes: PersistenceNotification<T>) {
        if let changes = changes as? PersistenceNotification<SelectedMealPlan> {
            switch changes {
            case .update:
                reload.accept(())
            default:
                break
            }
        }
    }
}
