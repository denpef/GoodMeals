import RxSwift
import UIKit

final class ShoppingListViewController: ViewController<ShoppingListViewModel> {
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.rowHeight = 60
        view.allowsSelection = false
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.register(GroceryCell.self, forCellReuseIdentifier: GroceryCell.reuseIdentifier)
        return view
    }()

    override func setupInterface() {
        title = "Shopping list"

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic

        let delelteItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: nil)
        navigationItem.rightBarButtonItem = delelteItem

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

    override func bind() {
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: GroceryCell.reuseIdentifier, cellType: GroceryCell.self)) { _, item, cell in
                let vm = GroceryCellViewModel(with: item)
                cell.configure(with: vm)
                vm.markedChange
                    .map { vm.item }
                    .bind(to: self.viewModel.markedItem)
                    .disposed(by: cell.disposeBag)

                vm.delete
                    .map { vm.item }
                    .bind(to: self.viewModel.deleteItem)
                    .disposed(by: cell.disposeBag)
            }.disposed(by: disposeBag)

        navigationItem.rightBarButtonItem?.rx
            .tap
            .bind(to: viewModel.deleteAllList)
            .disposed(by: disposeBag)
    }
}
