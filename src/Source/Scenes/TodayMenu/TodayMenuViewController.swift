import RxSwift
import UIKit

/**
 Screen show current meal plan recipes by days begin from today
 */
final class TodayMenuViewController: ViewController<TodayMenuViewModel> {
    private var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.apply(Stylesheet.TodayMenu.table)
        return view
    }()

    override func setupInterface() {
        tableView.register(TodayMenuCell.self, forCellReuseIdentifier: TodayMenuCell.reuseIdentifier)
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
            .drive(tableView.rx
                .items(cellIdentifier: TodayMenuCell.reuseIdentifier, cellType: TodayMenuCell.self)) { [weak self] _, item, cell in
                guard let self = self else {
                    return
                }
                cell.configure(with: item.meals, dayNumber: item.dayNumber, numberOfPages: item.meals.count)
                cell.recipeSelected
                    .flatMap { Observable.from(optional: $0) }
                    .bind(to: self.viewModel.recipeSelected)
                    .disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)

        navigationItem.rightBarButtonItem?.rx
            .tap
            .bind(to: viewModel.mealPlansAction)
            .disposed(by: disposeBag)

        viewModel.reload.accept(())
    }
}
