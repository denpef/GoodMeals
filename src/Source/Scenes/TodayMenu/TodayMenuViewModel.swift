import Foundation
import RxSwift
import RxCocoa

final class TodayMenuViewModel {
    
    // MARK: - Input
    
    // MARK: - Output
    
    var items: BehaviorSubject<[String]>
    
    // MARK: - Private properties
    
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    init() {
        items = BehaviorSubject(value:["1","2","3"])
    }
}
