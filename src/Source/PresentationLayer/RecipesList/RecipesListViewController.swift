import UIKit
import RxSwift

class RecipesListViewController: ViewModelClasses.ViewController<RecipesListViewModel> {
    private let factory: ViewModelFactory
    
    init(factory: ViewModelFactory) {
        self.factory = factory
        super.init(nibName: nil, bundle: nil)
        self.model = factory.makeRecipesListViewModel()
        self.view.backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func bind() {
    }
}
