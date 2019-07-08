import RxSwift
import UIKit

final class GroceryCell: UITableViewCell {
    weak var viewModel: GroceryCellViewModel?
    var disposeBag = DisposeBag()

    private lazy var markedButton = UIButton()
    private lazy var deleteButton = UIButton()
    private lazy var titleLabel = UILabel()
    private lazy var amountLabel = UILabel()

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureButton()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: GroceryCellViewModel) {
        self.viewModel = viewModel
        bind()
    }

    private func bind() {
        guard let viewModel = viewModel else {
            return
        }

        markedButton.rx.tap
            .bind(to: viewModel.markedAction)
            .disposed(by: disposeBag)

        deleteButton.rx.tap
            .bind(to: viewModel.deleteAction)
            .disposed(by: disposeBag)

        viewModel.title
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.amount
            .drive(amountLabel.rx.text)
            .disposed(by: disposeBag)

        viewModel.marked.drive(onNext: { [weak self] marked in
            guard let self = self else {
                return
            }
            switch marked {
            case true:
                self.markedButton.apply(Stylesheet.GroceryCell.markButtonMarked)
                self.deleteButton.apply(Stylesheet.GroceryCell.deleteButtonMarked)
                self.amountLabel.apply(Stylesheet.GroceryCell.amountLabelMarked)
                self.titleLabel.apply(Stylesheet.GroceryCell.titleLabelMarked)
            case false:
                self.markedButton.apply(Stylesheet.GroceryCell.markButtonUnmarked)
                self.deleteButton.apply(Stylesheet.GroceryCell.deleteButtonUnmarked)
                self.amountLabel.apply(Stylesheet.GroceryCell.amountLabelUnmarked)
                self.titleLabel.apply(Stylesheet.GroceryCell.titleLabelUnmarked)
            }
        }).disposed(by: disposeBag)
    }

    private func configureButton() {
        addSubview(markedButton)
        markedButton.translatesAutoresizingMaskIntoConstraints = false
        markedButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        markedButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        markedButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        markedButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true

        addSubview(deleteButton)
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        deleteButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true

        addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        amountLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        amountLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -48).isActive = true

        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -106).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 48).isActive = true
    }
}
