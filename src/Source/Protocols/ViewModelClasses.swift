import UIKit
import RxSwift
import RxCocoa
import RxDataSources

enum ViewModelClasses {
    
    class ViewController<T: ViewModel>: UIViewController, ViewModelBased {
        typealias ViewModelType = T
        var model: ViewModelType?
        
        private let disposeBag = DisposeBag()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            bind()
        }
        
        func bind() {
            fatalError("Must override")
        }
    }

}
