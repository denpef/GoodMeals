import RxSwift
import UIKit

/**
 Class define UIViewController matching MVVM pattern
 */
class ViewController<ViewModelType>: UIViewController {
    /// ViewModel responsible for the business logic of the module
    var viewModel: ViewModelType

    /// Thread safe bag that disposes added disposables on `deinit`
    let disposeBag = DisposeBag()

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required init(viewModel: ViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInterface()
        bind()
    }

    /// Method to describe subview, controls and constrints
    func setupInterface() {}

    /// There must be a binding to the ViewModel
    /// required condition - overriding func
    func bind() {
        fatalError("bind is not overriden")
    }
}
