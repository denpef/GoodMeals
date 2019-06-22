import Foundation
import RealmSwift
import RxCocoa
import RxSwift

final class MealPlansListViewModel {
    var router: MealPlansListRouterType?

    // MARK: - Input

    var mealPlan = PublishSubject<MealPlan>()

    // MARK: - Output

    var items: BehaviorSubject<[MealPlan]>

    // MARK: - Private properties

    private let disposeBag = DisposeBag()

    // MARK: - Init

    init(persistanceService: PersistenceService) {
        let plans = persistanceService.objects(MealPlan.self, filter: nil, sortDescriptors: nil)
        items = BehaviorSubject(value: plans)

        mealPlan.subscribe(onNext: { [weak self] plan in
            self?.router?.navigateToMealPlan(mealPlan: plan)
        }).disposed(by: disposeBag)
    }
}
