import UIKit
import RxSwift
import RxDataSources

final class IngredientsListViewController: UIViewController {
    let disposeBag = DisposeBag()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(IngredientCell.self, forCellReuseIdentifier: IngredientCell.reuseIdentifier)
        return tableView
    }()
    private var viewModel: IngredientsListViewModel
    
    init(factory: ViewModelFactory) {
        viewModel = factory.makeIngredientsListViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Ingredients"
        view.setTopToBottomGradientBackground(topColor: .black, bottomColor: .yellow)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.setTopToBottomGradientBackground(topColor: .red, bottomColor: .green)
        bind()
    }
    
    func bind() {
        viewModel
            .items
            .bind(to: tableView.rx.items(
                cellIdentifier: IngredientCell.reuseIdentifier,
                cellType: IngredientCell.self)) { row, model, cell in
                   cell.textLabel?.text = model.name
            }.disposed(by: disposeBag)
    }
}
