import UIKit
import RxSwift
import RxCocoa

final class GroceryCell: UITableViewCell {
    
    var viewModel: GroceryCellViewModel?
    var disposeBag = DisposeBag()
    
    lazy var markedButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: GroceryCellViewModel) {
        self.viewModel = viewModel
        guard let item = self.viewModel?.item else {
            return
        }
        textLabel?.text = "\(item.ingredient?.name ?? "")"
        markedButton.backgroundColor = item.marked ? .black : .green
        bind()
    }
    
    private func bind() {
        guard let viewModel = viewModel else {
            return
        }
        
        markedButton.rx.tap
            .bind(to: viewModel.markedChange)
            .disposed(by: disposeBag)
    }
    
    private func configureButton() {
        addSubview(markedButton)
        markedButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            markedButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            markedButton.heightAnchor.constraint(equalToConstant: 20),
            markedButton.widthAnchor.constraint(equalToConstant: 20),
            markedButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
            ])
    }
}

