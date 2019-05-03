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
            fatalError("bind is not overriden")
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
                fatalError("bind is not overriden")
            }
        }
        
        class ViewController<T: ViewModelWithCollection, Cell: UICollectionViewCell>: Controllers.ViewController<T> where Cell: TypedViewModel, Cell.ViewModelType == T.CollectionType {
            
            typealias CellType = Cell
            
            var collectionView: UICollectionView {
                fatalError("collectionView is not overriden")
            }
            
            override func viewDidLoad() {
                super.viewDidLoad()
                bindItems()
                
            }
            
            func bindItems() {
                model?
                    .collection
                    .bind(to: collectionView.rx.items(cellIdentifier: CellType.reuseIdentifier,
                                                      cellType: CellType.self)) { row, model, cell in
                                                        cell.model = model
                    }.disposed(by: disposeBag)
            }
        }
    }
}
