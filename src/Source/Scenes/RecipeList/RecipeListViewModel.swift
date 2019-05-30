import UIKit
import RxSwift
import RxDataSources

final class RecipesListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: RecipesListViewModel
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = 90
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.reuseIdentifier)
        return tableView
    }()
    private lazy var addNewItemButton = {
        return UIButton()
    }()
    
    init(viewModel: RecipesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipes"
        
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
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: RecipeCell.reuseIdentifier))
            { row, Recipe, cell in
                cell.textLabel?.text = Recipe.name
                cell.selectionStyle = .none
                cell.backgroundColor = .blue
            }.disposed(by: disposeBag)
        
        navigationItem.rightBarButtonItem?.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .bind(to: viewModel.addNewItem)
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Recipe.self)
            .bind(to: viewModel.selectItem)
            .disposed(by: disposeBag)
    }
}
