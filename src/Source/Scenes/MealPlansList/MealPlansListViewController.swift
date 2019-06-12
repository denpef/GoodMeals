import UIKit
import RxSwift
import RxCocoa

final class MealPlansListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.rowHeight = 264
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()
    
    private var viewModel: MealPlansListViewModel
    
    init(viewModel: MealPlansListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Meal plans"
        setupTableView()
        bind()
    }
    
    private func setupTableView() {
        tableView.register(MealPlanCell.self, forCellReuseIdentifier: MealPlanCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    
    private func bind() {
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: MealPlanCell.reuseIdentifier,
                                         cellType: MealPlanCell.self)) { _, item, cell in
                                            cell.configure(with: item.dailyPlans)
            }.disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(MealPlan.self)
            .bind(to: viewModel.mealPlan)
            .disposed(by: disposeBag)
    }
}
