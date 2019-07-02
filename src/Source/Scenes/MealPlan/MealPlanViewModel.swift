import RxCocoa
import RxSwift

class MealPlanViewModel {
    var router: MealPlanRouterType?
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

    // MARK: - Init

    init(mealPlanService: MealPlanServiceType, mealPlan: MealPlan) {
        self.mealPlanService = mealPlanService
        self.mealPlan = mealPlan
        title = mealPlan.name

        tap.subscribe(onNext: { _ in
            self.router?.navigateToConfirmation(mealPlan: self.mealPlan)
        }).disposed(by: disposeBag)

        mealPlan.dailyPlans.forEach { dailyPlan in
            let section = MealPlanTableViewSection(header: "Day \(dailyPlan.dayNumber)", items: dailyPlan.meals.compactMap { $0.recipe })
            sections.append(section)
        }

        recipe.subscribe(onNext: { [weak self] recipeId in
            self?.router?.navigateToRecipe(recipeId: recipeId)
        }).disposed(by: disposeBag)
    }
}
