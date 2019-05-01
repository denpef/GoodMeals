import UIKit
import RxSwift
import RxDataSources

class RecipesListViewController: Controllers.CollectionView.ViewController<RecipesListViewModel, RecipesCollectionViewCell> {
    private let factory: ViewModelFactory
    
    let myCollection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout.init())
    
    override var collectionView: UICollectionView {
        return myCollection
    }
    
    init(factory: ViewModelFactory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
        view.addSubview(collectionView)
        collectionView.backgroundColor = .green
        collectionView.alwaysBounceHorizontal = true
        collectionView.isPagingEnabled = true
        self.model = factory.makeRecipesListViewModel()
        view.setTopToBottomGradientBackground(topColor: UIColor.Common.white,
                                              bottomColor: UIColor.Common.ghostWhite)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    override func bind() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RecipesCollectionViewCell: Controllers.CollectionView.Cell<RecipesCellViewModel> {
    
}

class RecipesCellViewModel: ViewModel {
    
}
