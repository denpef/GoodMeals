import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class TodayMenuViewModel {
    
    var router: TodayMenuRouterType?
    
    // MARK: - Input
    
    var mealPlanService: MealPlanServiceType
    var showMealPlans = PublishRelay<Void>()
    
    // MARK: - Output
    
    var items: BehaviorSubject<[DailyPlan]> = BehaviorSubject(value: [])
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(mealPlanService: MealPlanServiceType) {
        self.mealPlanService = mealPlanService
        mealPlanService.subscribeCollection(subscriber: self)
        
        showMealPlans.subscribe(onNext: { item in
            self.router?.navigateToMealPlansList()
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
