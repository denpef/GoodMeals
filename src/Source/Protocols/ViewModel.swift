import Foundation
import RxSwift

protocol ViewModel {}

protocol ViewModelBased: AnyObject {
    associatedtype ViewModelType: ViewModel
    var model: ViewModelType? { get set }
    func bind()
}
