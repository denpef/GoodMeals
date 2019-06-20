import UIKit
import RxSwift

final class ShoppingListViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    private var viewModel: ShoppingListViewModel
    
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.rowHeight = 60
        view.allowsSelection = false
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.register(GroceryCell.self, forCellReuseIdentifier: GroceryCell.reuseIdentifier)
        return view
    }()
    
    init(viewModel: ShoppingListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Shopping list"
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
        
        bind()
    }
    
    func bind() {
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: GroceryCell.reuseIdentifier, cellType: GroceryCell.self))
            { row, item, cell in
                let vm = GroceryCellViewModel(with: item)
                cell.configure(with: vm)
                vm.markedChange
                    .map { vm.item }
                    .bind(to: self.viewModel.marked)
                    .disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)
    }
}
