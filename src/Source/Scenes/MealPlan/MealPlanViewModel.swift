import Foundation
import RxSwift
import RxCocoa

class MealPlanViewModel {
    
    var router: MealPlanRouterType?
    
    // MARK: - Input
    
    let tap = PublishRelay<Void>()
    
    // MARK: - Output
    
    var plan: BehaviorRelay<MealPlan>
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    private let mealPlanService: MealPlanServiceType
    
    // MARK: - Init
    
    init(mealPlanService: MealPlanServiceType, mealPlan: MealPlan) {
        self.mealPlanService = mealPlanService
        plan = BehaviorRelay(value: mealPlan)
        
        tap.subscribe(onNext: {
            self.router?.navigateToDateSelection(mealPlan: self.plan.value)
        }).disposed(by: disposeBag)
    }
}