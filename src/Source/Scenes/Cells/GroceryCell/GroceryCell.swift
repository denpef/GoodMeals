import RxCocoa
import RxSwift
import UIKit

final class GroceryCell: UITableViewCell {
    var viewModel: GroceryCellViewModel?
    var disposeBag = DisposeBag()

    private lazy var markedButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.image.image, tintColor: .green)
        return button
    }()

    private lazy var deleteButton: UIButton = {
        let button = UIButton()
        button.setImage(Asset.cancel.image, tintColor: UIColor.Common.deleteItem)
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()

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
        guard let item = self.viewModel?.item else {
            return
        }
        titleLabel.text = "\(item.ingredient?.name ?? "")"
        titleLabel.textColor = item.marked ? UIColor.Common.markedText : UIColor.Common.controlBackground

        amountLabel.text = item.amount.formattedMass

        markedButton.tintColor = item.marked ? UIColor.Common.ghostWhite : .green
        deleteButton.tintColor = item.marked ? UIColor.Common.ghostWhite : UIColor.Common.deleteItem

        bind()
    }

    private func bind() {
        guard let viewModel = viewModel else {
            return
        }

        markedButton.rx.tap
            .bind(to: viewModel.markedChange)
            .disposed(by: disposeBag)

        deleteButton.rx.tap
            .bind(to: viewModel.delete)
            .disposed(by: disposeBag)
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
