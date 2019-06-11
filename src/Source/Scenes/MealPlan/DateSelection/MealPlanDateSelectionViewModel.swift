import Foundation
import RxSwift
import RxCocoa

class MealPlanDateSelectionViewModel {
    
    var router: MealPlanDateSelectionRouterType?
    
    // MARK: - Input
    
    let tap = PublishRelay<Void>()
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    private let mealPlanService: MealPlanServiceType
    private let mealPlan: MealPlan
    
    // MARK: - Init
    
    init(mealPlanService: MealPlanServiceType, mealPlan: MealPlan) {
        self.mealPlanService = mealPlanService
        self.mealPlan = mealPlan
        
        tap.subscribe(onNext: { [weak self] _ in
            self?.savePlan()
        }).disposed(by: disposeBag)
    }
    
    private func savePlan() {
        router?.navigateToResult()
    }
}