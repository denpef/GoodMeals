import Foundation
import RxSwift
import RxCocoa
import RealmSwift

final class TodayMenuViewModel {
    
    // MARK: - Input
    
    // MARK: - Output
    
    var items: BehaviorSubject<[DailyPlan]>
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init(persistanceService: PersistenceService) {
        let filter = NSPredicate(format: #keyPath(SelectedMealPlanObject.startDate) + "<= %@", Date() as NSDate)
        let sortDescription = SortDescriptor(keyPath: #keyPath(SelectedMealPlanObject.startDate), ascending: false)
        let plans = persistanceService.objects(SelectedMealPlan.self,
                                               filter: filter,
                                               sortDescriptors: [sortDescription])
        if let dailyPlans = plans.first?.mealPlan?.dailyPlans {
            items = BehaviorSubject(value: dailyPlans)
        } else {
            items = BehaviorSubject(value: [])
        }
    }
}
