import UIKit
import RxSwift
import RxCocoa

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
    
    private var datePicker: UIDatePicker = {
        let control = UIDatePicker(frame: .zero)
        control.datePickerMode = .date
        return control
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
            selectButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
        
        view.addSubview(datePicker)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 162),
            datePicker.bottomAnchor.constraint(equalTo: selectButton.topAnchor)])
        
        bind()
    }
    
    func bind() {
        selectButton.rx
            .tap
            .debounce(0.2, scheduler: MainScheduler.instance)
            .bind(to: viewModel.tap)
            .disposed(by: disposeBag)
        
        datePicker.rx.value
            .bind(to: viewModel.date)
            .disposed(by: disposeBag)
    }
}
