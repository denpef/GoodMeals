import RxDataSources
import RxSwift

import UIKit

/**
 Represent recipe list of plan and let to choose plan as current
 */
final class MealPlanViewController: ViewController<MealPlanViewModel> {
    private var dataSource: RxTableViewSectionedReloadDataSource<MealPlanTableViewSection>?

    private lazy var tableView = UITableView(style: Stylesheet.MealPlan.table)
    private var selectButton = UIButton(style: Stylesheet.MealPlan.selectButton)

    private var buttonCenterYConstraint: NSLayoutConstraint?

    override func setupInterface() {
        view.backgroundColor = UIColor.Common.mintCream

        tableView.register(RecipeCell.self, forCellReuseIdentifier: RecipeCell.reuseIdentifier)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        view.addSubview(selectButton)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        selectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        selectButton.heightAnchor.constraint(equalToConstant: 40).isActive = true

        buttonCenterYConstraint = selectButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32)
        buttonCenterYConstraint?.isActive = true
    }

    override func bind() {
        viewModel.title
            .drive(rx.title)
            .disposed(by: disposeBag)

        selectButton.rx
            .tap
            .debounce(0.2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.setMealPlanCurrent)
            .disposed(by: disposeBag)

        dataSource = RxTableViewSectionedReloadDataSource<MealPlanTableViewSection>(configureCell: { _, tableView, indexPath, recipe in
            let cell = tableView.dequeueReusableCell(withIdentifier: RecipeCell.reuseIdentifier,
                                                     for: indexPath)
            if let cell = cell as? RecipeCell {
                cell.configure(with: recipe)
            }
            return cell
        })

        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)

        if let dataSource = dataSource {
            viewModel.sections
                .bind(to: tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
        }

        tableView.rx.modelSelected(Recipe.self)
            .map { $0.id }
            .bind(to: viewModel.showRecipe)
            .disposed(by: disposeBag)

        tableView.rx.didScroll.map {
            self.tableView.contentOffset.y
        }
        .subscribe(onNext: { offset in
            self.buttonCenterYConstraint?.constant = min(max(-40, offset - 32), 25)
        }).disposed(by: disposeBag)
    }
}

extension MealPlanViewController: UITableViewDelegate {
    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 42)
        let headerView = UIView(frame: frame)

        let sectionLabel = UILabel(frame: CGRect(origin: frame.origin, size: CGSize(width: 100, height: frame.height - 8)))
        sectionLabel.center = headerView.center
        sectionLabel.layer.cornerRadius = (frame.height - 8) / 2
        sectionLabel.text = dataSource?.sectionModels[section].header
        sectionLabel.apply(Stylesheet.MealPlan.headerLabel)

        headerView.addSubview(sectionLabel)

        return headerView
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 42
    }
}
