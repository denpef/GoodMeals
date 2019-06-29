import RxCocoa
import RxSwift
import UIKit

final class RecipeServingCell: UICollectionViewCell {
    var countOfServing = BehaviorRelay<Int>(value: 2)

    var disposeBag: DisposeBag

    private var servingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private let calorificalLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private let timeForPreparingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()

    private let plusButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(Asset.plus.image, tintColor: UIColor.Common.controlBackground)
        button.contentMode = .scaleAspectFill
        return button
    }()

    private let minusButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(Asset.minus.image, tintColor: UIColor.Common.controlBackground)
        return button
    }()

    let addToShoppingListButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(Asset.shoppingBag.image, tintColor: UIColor.Common.controlText)
        return button
    }()

    override init(frame: CGRect) {
        disposeBag = DisposeBag()
        super.init(frame: frame)
        configureInfoLabels()
        configureServing()
        configureButtons()
        bind()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }

    private func bind() {
        countOfServing.map {
            let regularAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .regular)]
            let boldAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .bold)]
            let attributedText = NSMutableAttributedString(string: "Serving: ", attributes: regularAttributes)
            attributedText.append(NSMutableAttributedString(string: "\($0)", attributes: boldAttributes))
            return attributedText
        }
        .bind(to: servingLabel.rx.attributedText)
        .disposed(by: disposeBag)

        plusButton.rx.tap.subscribe(onNext: {
            self.countOfServing.accept(self.countOfServing.value + 1)
        }).disposed(by: disposeBag)

        minusButton.rx.tap.subscribe(onNext: {
            self.countOfServing.accept(self.countOfServing.value - 1)
        }).disposed(by: disposeBag)
    }

    func configure(calorifical: Int, timeForPreparing: String) {
        calorificalLabel.text = "\(calorifical.description) KCal"
        timeForPreparingLabel.text = timeForPreparing
    }

    private func configureInfoLabels() {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.contentMode = .scaleAspectFit
        stackView.spacing = 6
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        stackView.addArrangedSubview(calorificalLabel)
        stackView.addArrangedSubview(timeForPreparingLabel)
    }

    private func configureServing() {
        let buttonView = UIView()

        buttonView.addSubview(minusButton)
        buttonView.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.widthAnchor.constraint(equalTo: plusButton.heightAnchor, multiplier: 1).isActive = true
        plusButton.topAnchor.constraint(equalTo: buttonView.topAnchor).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor).isActive = true
        plusButton.leadingAnchor.constraint(equalTo: buttonView.centerXAnchor, constant: 10).isActive = true

        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.widthAnchor.constraint(equalTo: minusButton.heightAnchor, multiplier: 1).isActive = true
        minusButton.topAnchor.constraint(equalTo: buttonView.topAnchor).isActive = true
        minusButton.bottomAnchor.constraint(equalTo: buttonView.bottomAnchor).isActive = true
        minusButton.trailingAnchor.constraint(equalTo: buttonView.centerXAnchor, constant: -10).isActive = true

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.contentMode = .scaleAspectFit
        stackView.spacing = 6
        addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        stackView.addArrangedSubview(servingLabel)
        stackView.addArrangedSubview(buttonView)
    }

    private func configureButtons() {
        addSubview(addToShoppingListButton)
        addToShoppingListButton.translatesAutoresizingMaskIntoConstraints = false
        addToShoppingListButton.widthAnchor.constraint(equalTo: addToShoppingListButton.heightAnchor,
                                                       multiplier: 1).isActive = true
        addToShoppingListButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        addToShoppingListButton.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        addToShoppingListButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
}
