import Foundation
import RxSwift

class RecipesListViewModel: ViewModelWithCollection {
    required init(withServices services: IngredientsService) {
        
    }
    
    typealias Services = IngredientsService
    
    var collection: Observable<[RecipesCellViewModel]>
    
    let factory: ViewModelFactory
    private var disposeBag = DisposeBag()
    
    private var _collection = Variable<[RecipesCellViewModel]>([])
    
    required init(factory: ViewModelFactory) {
        self.factory = factory
        self.collection = _collection.asObservable()
    }
}
