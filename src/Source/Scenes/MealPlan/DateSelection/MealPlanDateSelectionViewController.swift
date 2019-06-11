import UIKit
import RxSwift

final class MealPlanDateSelectionViewController: UIViewController {
    private let disposeBag = DisposeBag()
    private var viewModel: MealPlanDateSelectionViewModel
    
    private var selectButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = UIColor.Common.controlText
        button.backgroundColor = UIColor.Common.controlBackground
        button.setTitle("Select plan", for: .normal)
        return button
    }()
    
    init(viewModel: MealPlanDateSelectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select date"
        
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
