import RxCocoa
import RxSwift

class MealPlanViewModel {
    var recipe = PublishSubject<String>()
    var mealPlan: MealPlan
    var title: String

    // MARK: - Input

    let tap = PublishRelay<Void>()

    // MARK: - Output

    var sections = [MealPlanTableViewSection]()

    // MARK: - Private properties

    private let disposeBag = DisposeBag()
    private let mealPlanService: MealPlanServiceType
    private let router: MealPlanRouterType

    // MARK: - Init

    init(mealPlanService: MealPlanServiceType, mealPlan: MealPlan, router: MealPlanRouterType) {
        self.mealPlanService = mealPlanService
        self.mealPlan = mealPlan
        self.router = router
        title = mealPlan.name

        tap.subscribe(onNext: { _ in
            self.router.navigateToConfirmation(mealPlan: self.mealPlan)
        }).disposed(by: disposeBag)

        mealPlan.dailyPlans.forEach { dailyPlan in
            let section = MealPlanTableViewSection(header: "Day \(dailyPlan.dayNumber)", items: dailyPlan.meals.compactMap { $0.recipe })
            sections.append(section)
        }

        recipe.subscribe(onNext: { [weak self] recipeId in
            self?.router.navigateToRecipe(recipeId: recipeId)
        }).disposed(by: disposeBag)
    }
}
