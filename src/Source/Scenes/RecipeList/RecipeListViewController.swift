import RxDataSources
import RxSwift
import UIKit

final class RecipesListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: RecipesListViewModel

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.rowHeight = 320
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.reuseIdentifier)
        return view
    }()

    init(viewModel: RecipesListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Recipes"

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        bind()
    }

    func bind() {
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: RecipeCell.reuseIdentifier, cellType: RecipeCell.self)) { _, recipe, cell in
                cell.configure(with: recipe)
            }.disposed(by: disposeBag)

        tableView.rx.modelSelected(Recipe.self)
            .bind(to: viewModel.selectItem)
            .disposed(by: disposeBag)
    }
}
