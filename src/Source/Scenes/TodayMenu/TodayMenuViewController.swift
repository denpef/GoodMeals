import RxSwift
import UIKit

final class TodayMenuViewController: ViewController<TodayMenuViewModel> {
    private var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.rowHeight = 304
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.allowsSelection = false
        view.register(TodayMenuCell.self, forCellReuseIdentifier: TodayMenuCell.reuseIdentifier)
        return view
    }()

    override func setupInterface() {
        title = "Today menu"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: nil)
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    override func bind() {
        viewModel.items
            .bind(to: tableView.rx
                .items(cellIdentifier: TodayMenuCell.reuseIdentifier, cellType: TodayMenuCell.self)) { [weak self] _, item, cell in
                guard let self = self else {
                    return
                }
                cell.configure(with: item.meals, dayNumber: item.dayNumber, numberOfPages: item.meals.count)
                cell.recipeSelected
                    .bind(to: self.viewModel.recipeSelected)
                    .disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)

        navigationItem.rightBarButtonItem?.rx
            .tap
            .bind(to: viewModel.showMealPlans)
            .disposed(by: disposeBag)
    }
}
