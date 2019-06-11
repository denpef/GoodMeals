import Foundation
import RxSwift
import RxCocoa

class MealPlanSelectionResultViewModel {
    
    var router: MealPlanSelectionResultRouterType?
    
    // MARK: - Input
    
    let tap = PublishRelay<Void>()
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init() {
        tap.subscribe(onNext: { [weak self] date in
            self?.router?.navigateToPlans()
        }).disposed(by: disposeBag)
    }
}
