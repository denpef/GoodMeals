import RxDataSources
import RxSwift

import UIKit

final class MealPlanViewController: ViewController<MealPlanViewModel> {
    private var dataSource: RxTableViewSectionedReloadDataSource<MealPlanTableViewSection>?

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.rowHeight = 264
        view.backgroundColor = .white
        view.separatorStyle = .none
        return view
    }()

    private var selectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.Common.controlText
        button.backgroundColor = UIColor.Common.controlBackground
        button.setTitle("Select plan", for: .normal)
        button.layer.shadowOpacity = 0.15
        button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        button.layer.shadowRadius = 8
        button.layer.cornerRadius = 12
        button.layer.opacity = 0.95
        return button
    }()

    private var buttonCenterYConstraint: NSLayoutConstraint?

    override func setupInterface() {
        title = viewModel.title
        view.backgroundColor = .white

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
        selectButton.rx
            .tap
            .debounce(0.2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.tap)
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
            Observable.just(viewModel.sections)
                .bind(to: tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
        }

        tableView.rx.modelSelected(Recipe.self)
            .map { $0.id }
            .bind(to: viewModel.recipe)
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
        headerView.backgroundColor = .darkGray

        let sectionLabel = UILabel(frame: frame)
        sectionLabel.textAlignment = .center

        // get the title from the dataSource
        sectionLabel.text = dataSource?.sectionModels[section].header
        sectionLabel.textColor = UIColor.Common.subtitleLabelText
        sectionLabel.textAlignment = .center
        sectionLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)

        headerView.addSubview(sectionLabel)
        headerView.backgroundColor = .white

        return headerView
    }

    func tableView(_: UITableView, heightForHeaderInSection _: Int) -> CGFloat {
        return 42
    }
}
