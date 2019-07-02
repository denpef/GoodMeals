import RxCocoa
import RxSwift

final class TodayMenuViewModel {
    var router: TodayMenuRouterType?

    // MARK: - Input

    var mealPlanService: MealPlanServiceType
    var showMealPlans = PublishRelay<Void>()
    var recipeSelected = PublishRelay<Recipe?>()

    // MARK: - Output

    var items: BehaviorSubject<[DailyPlan]> = BehaviorSubject(value: [])

    // MARK: - Private properties

    private let disposeBag = DisposeBag()

    // MARK: - Init

    init(mealPlanService: MealPlanServiceType) {
        self.mealPlanService = mealPlanService
        mealPlanService.subscribeCollection(subscriber: self)

        showMealPlans.subscribe(onNext: { _ in
            self.router?.navigateToMealPlansList()
        }).disposed(by: disposeBag)

        recipeSelected.subscribe(onNext: { recipe in
            guard let recipe = recipe else {
                return
            }
            self.router?.navigateToRecipe(recipeId: recipe.id)
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
