import UIKit
import RxSwift
import RxCocoa
import RxDataSources

enum Controllers {
    class ViewController<T: ViewModel>: UIViewController, ViewModelBased {
        typealias ViewModelType = T
        var model: ViewModelType?
        
        let disposeBag = DisposeBag()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            bind()
        }
        
        func bind() {
            fatalError("Must override")
        }
    }
    
    enum CollectionView {
        
        class Cell<T: ViewModel>: UICollectionViewCell, TypedViewModel, ViewModelBased {
            typealias ViewModelType = T
            
            private let disposeBag = DisposeBag()
            
            var model: ViewModelType? {
                didSet {
                    bind()
                }
            }
            
            override func awakeFromNib() {
                super.awakeFromNib()
                bind()
            }
            
            func bind() {
                fatalError("Must override")
            }
        }
        
        class ViewController<T: ViewModelWithCollection, Cell: UICollectionViewCell>: Controllers.ViewController<T> where Cell: TypedViewModel, Cell.ViewModelType == T.CollectionType {
            
            typealias CellType = Cell
            
            var collectionView: UICollectionView {
                fatalError("Must be overriden")
            }
            
            override func viewDidLoad() {
                super.viewDidLoad()
                bindItems()
                
            }
            
            func bindItems() {
                model?.collection.bind(to: collectionView.rx.items(cellIdentifier: CellType.reuseIdentifier,
                                                                   cellType: CellType.self)) { row, model, cell in
                    
                    cell.model = model
                    
                    }.disposed(by: disposeBag)
            }
        }
    }
}
