import Foundation
import RxSwift

protocol ViewModel {
    associatedtype Services
    init (withServices services: Services)
}

protocol ViewModelBased: AnyObject {
    associatedtype ViewModelType: ViewModel
    var model: ViewModelType? { get set }
    func bind()
}

protocol ViewModelWithCollection: ViewModel {
    associatedtype CollectionType: ViewModel
    var collection: Observable<[CollectionType]> { get }
}

protocol TypedViewModel: AnyObject {
    associatedtype ViewModelType: ViewModel
    var model: ViewModelType? { get set }
    func bind()
}

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
