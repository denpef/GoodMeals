import UIKit
import RxSwift

final class ShoppingListViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: ShoppingListViewModel
    
    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero)
        view.backgroundColor = .clear
        view.alwaysBounceVertical = false
        view.alwaysBounceHorizontal = true
        view.showsHorizontalScrollIndicator  = false
        return view
    }()
    
    init(viewModel: ShoppingListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping list"
    }
}
