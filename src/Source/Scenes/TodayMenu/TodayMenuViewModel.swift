import RxCocoa
import RxSwift

final class TodayMenuViewModel {
    // MARK: - Input

    var mealPlansAction = PublishRelay<Void>()
    var recipeSelected = PublishRelay<Recipe>()

    // MARK: - Output

    var items = BehaviorSubject<[DailyPlan]>(value: [])

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private var router: TodayMenuRouterType
    private var mealPlanService: MealPlanServiceType

    // MARK: - Init

    init(mealPlanService: MealPlanServiceType, router: TodayMenuRouterType) {
        self.mealPlanService = mealPlanService
        self.router = router
        mealPlanService.subscribeCollection(subscriber: self)

        mealPlansAction.subscribe(onNext: { _ in
            self.router.navigateToMealPlansList()
        }).disposed(by: disposeBag)

        recipeSelected.subscribe(onNext: { recipe in
            self.router.navigateToRecipe(recipeId: recipe.id)
        }).disposed(by: disposeBag)
    }

    private func updateMealPlan() {
        let currentMealPlan = mealPlanService.getCurrentMealPlan()
        if let dailyPlans = currentMealPlan?.mealPlan?.dailyPlans {
            items.onNext(dailyPlans)
        } else {
            items.onNext([])
        }
    }
}

extension TodayMenuViewModel: PersistenceNotificationOutput {
    func didChanged<T>(_ changes: PersistenceNotification<T>) {
        if let changes = changes as? PersistenceNotification<SelectedMealPlan> {
            switch changes {
            case .initial, .update:
                updateMealPlan()
            default:
                break
            }
        }
    }
}
