import UIKit
import RxSwift
import RxCocoa
import RxDataSources

enum MVVM {
    class ViewController<V: ViewModel>: UIViewController, ViewModelBased {
        typealias ViewModelType = V
        
        let disposeBag = DisposeBag()
        
        var model: ViewModelType?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            bind()
        }
        
        func bind() {
            fatalError("Must be overriden")
        }
    }
}
