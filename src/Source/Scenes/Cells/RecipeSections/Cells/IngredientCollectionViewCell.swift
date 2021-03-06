import RxCocoa
import RxSwift
import UIKit

final class IngredientCollectionViewCell: UICollectionViewCell {
    var serving = BehaviorRelay<Int>(value: 0)

    private var amount: Int = 0
    private var ingredient: Ingredient?

    private var disposeBag = DisposeBag()

    private let nameLabel = UILabel(style: Stylesheet.IngredientCollectionViewCell.name)
    private let amountLabel = UILabel(style: Stylesheet.IngredientCollectionViewCell.amount)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.Common.mintCream
        configureLabels()
        bind()
    }

    private func bind() {
        serving.map { val -> String in
            (val * self.amount).formattedMass
        }.bind(to: amountLabel.rx.text)
            .disposed(by: disposeBag)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    func configure(ingredientAmount: IngredientAmount) {
        ingredient = ingredientAmount.ingredient
        amount = ingredientAmount.amount
        nameLabel.text = ingredient?.name
        amountLabel.text = amount.formattedMass
    }

    private func configureLabels() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -96).isActive = true

        addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        amountLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
    }
}
