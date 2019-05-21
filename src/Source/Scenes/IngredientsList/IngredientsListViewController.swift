import UIKit
import RxSwift
import RxDataSources

final class IngredientsListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: IngredientsListViewModel
    private var coordinator: SceneCoordinator
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.reuseIdentifier)
        return tableView
    }()
    private lazy var addNewItemButton = {
        return UIButton()
    }()
    
    init(viewModel: IngredientsListViewModel, coordinator: SceneCoordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ingredients"
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.setTopToBottomGradientBackground(topColor: .red, bottomColor: .green)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                            target: nil,
                                                            action: nil)
        
        bind()
    }
    
    func bind() {
        viewModel
            .items
            .bind(to: tableView.rx.items(cellIdentifier: IngredientCell.reuseIdentifier))
                { row, ingredient, cell in
                    cell.textLabel?.text = ingredient.name
                    cell.selectionStyle = .none
                }.disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem?.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: {
                self.coordinator.showIngredient(sender: self)
            }).disposed(by: disposeBag)
//            .bind(to: viewModel.addNewItem)
//            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Ingredient.self)
            .bind(to: viewModel.selectItem)
            .disposed(by: disposeBag)
    }
}
