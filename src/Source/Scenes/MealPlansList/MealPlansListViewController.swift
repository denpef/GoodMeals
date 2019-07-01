import RxCocoa
import RxSwift
import UIKit

final class MealPlansListViewController: ViewController<MealPlansListViewModel> {
    private var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.rowHeight = 186
        view.backgroundColor = .clear
        view.separatorStyle = .none
        return view
    }()

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
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    override func bind() {
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: MealPlanCell.reuseIdentifier,
                                         cellType: MealPlanCell.self)) { _, item, cell in
                cell.configure(with: item.image)
            }.disposed(by: disposeBag)

        tableView.rx
            .modelSelected(MealPlan.self)
            .bind(to: viewModel.mealPlan)
            .disposed(by: disposeBag)
    }
}
