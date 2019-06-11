import UIKit
import RxSwift
import RxCocoa

final class MealPlansListViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    private var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.rowHeight = 284
        view.backgroundColor = .clear
        view.separatorStyle = .none
        view.allowsSelection = true
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
        tableView.register(MealPlanCell.self, forCellReuseIdentifier: "TableViewCellId")
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([tableView.topAnchor.constraint(equalTo: view.topAnchor),
                                     tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                                     tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                                     tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)])
    }
    
    private func bind() {
        viewModel.items
            .bind(to: tableView.rx.items(cellIdentifier: "TableViewCellId",
                                         cellType: MealPlanCell.self)) { _, item, cell in
                                            cell.configure(with: item.dailyPlans)
            }.disposed(by: disposeBag)
        
        tableView.rx
            .modelSelected(MealPlan.self)
            .bind(to: viewModel.mealPlan)
            .disposed(by: disposeBag)
    }
}

final class MealPlanCell: UITableViewCell {
//    private let disposeBag = DisposeBag()
    
    private lazy var titleIMageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        contentView.addSubview(titleIMageView)
        titleIMageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([titleIMageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                                     titleIMageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                                     titleIMageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                                     titleIMageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)])
    }
    
    func configure(with plans: [DailyPlan]?) {
        if let imagePath = plans?.first?.meals.first?.recipe?.image {
            titleIMageView.loadImage(from: imagePath)
        }
    }
}
