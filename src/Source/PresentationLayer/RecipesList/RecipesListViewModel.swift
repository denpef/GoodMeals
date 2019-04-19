import Foundation
import RxSwift

class RecipesListViewModel: ViewModel {
    let factory: ViewModelFactory
    private var disposeBag = DisposeBag()
    
    required init(factory: ViewModelFactory) {
        self.factory = factory
    }
    
    func viewModel(for segueIdentifier: String?, sender: ViewModel?) -> ViewModel? {
        return nil
    }
}
