import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class TodayMenuViewModel {
    
    // MARK: - Input
    
    var mealPlanService: MealPlanServiceType
    
    // MARK: - Output
    
    var items: BehaviorSubject<[DailyPlan]> = BehaviorSubject(value: [])
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(mealPlanService: MealPlanServiceType) {
        self.mealPlanService = mealPlanService
        mealPlanService.subscribeCollection(subscriber: self)
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
