import UIKit
import RxSwift

final class MealPlanSelectionResultViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: MealPlanSelectionResultViewModel
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Common.controlText
        label.backgroundColor = UIColor.Common.controlBackground
        label.text = "Success"
        return label
    }()
    
    private var selectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.Common.controlText
        button.backgroundColor = UIColor.Common.controlBackground
        button.setTitle("Back to plans ->", for: .normal)
        return button
    }()
    
    init(viewModel: MealPlanSelectionResultViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select date"
        
        view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        
        view.addSubview(selectButton)
        selectButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            selectButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            selectButton.heightAnchor.constraint(equalToConstant: 50),
            selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
            ])
        
        bind()
    }
    
    func bind() {
        selectButton.rx
            .tap
            .debounce(0.2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.tap)
            .disposed(by: disposeBag)
    }
}
