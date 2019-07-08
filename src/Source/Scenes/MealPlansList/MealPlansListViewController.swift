import RxSwift
import UIKit

/**
 Available meal plan list screen
 */
final class MealPlansListViewController: ViewController<MealPlansListViewModel> {
    private var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.apply(Stylesheet.MealPlansList.table)
        return view
    }()

    override func setupInterface() {
        title = "Meal plans"
        setupTableView()
    }

    private func setupTableView() {
        view.backgroundColor = .white
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
            .drive(tableView.rx.items(cellIdentifier: MealPlanCell.reuseIdentifier,
                                      cellType: MealPlanCell.self)) { _, item, cell in
                cell.configure(with: item.image)
            }.disposed(by: disposeBag)

        tableView.rx
            .modelSelected(MealPlan.self)
            .bind(to: viewModel.mealPlanDidSelect)
            .disposed(by: disposeBag)

        viewModel.reload.accept(())
    }
}
