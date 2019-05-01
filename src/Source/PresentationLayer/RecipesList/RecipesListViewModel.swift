import Foundation
import RxSwift

class RecipesListViewModel: ViewModelWithCollection {
    
    var collection: Observable<[RecipesCellViewModel]>
    
    let factory: ViewModelFactory
    private var disposeBag = DisposeBag()
    
    private var _collection = Variable<[RecipesCellViewModel]>([])
    
    required init(factory: ViewModelFactory) {
        self.factory = factory
        self.collection = _collection.asObservable()
    }
    
    func viewModel(for segueIdentifier: String?, sender: ViewModel?) -> ViewModel? {
        return nil
    }
}
