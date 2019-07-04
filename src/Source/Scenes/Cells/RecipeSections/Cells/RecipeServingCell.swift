import RxCocoa
import RxSwift
import UIKit

final class RecipeServingCell: UICollectionViewCell {
    var countOfServing = BehaviorRelay<Int>(value: 2)

    var disposeBag: DisposeBag

    let addShoppingButton = UIButton(style: Stylesheet.ServingCell.addToShoppingList)

    private let plusButton = UIButton(style: Stylesheet.ServingCell.plus)
    private let minusButton = UIButton(style: Stylesheet.ServingCell.minus)

    private let buttonsView = UIView()

    private let servingLabel = UILabel(style: Stylesheet.ServingCell.info)
    private let calorificalLabel = UILabel(style: Stylesheet.ServingCell.info)
    private let timeForPreparingLabel = UILabel(style: Stylesheet.ServingCell.info)

    private let labelsStack = UIStackView(style: Stylesheet.ServingCell.verticalStack)
    private let buttonsStack = UIStackView(style: Stylesheet.ServingCell.verticalStack)

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
        addSubview(labelsStack)
        labelsStack.translatesAutoresizingMaskIntoConstraints = false
        labelsStack.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        labelsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        labelsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        labelsStack.widthAnchor.constraint(equalToConstant: 100).isActive = true

        labelsStack.addArrangedSubview(calorificalLabel)
        labelsStack.addArrangedSubview(timeForPreparingLabel)
    }

    private func configureServing() {
        buttonsView.addSubview(minusButton)
        buttonsView.addSubview(plusButton)

        plusButton.translatesAutoresizingMaskIntoConstraints = false
        plusButton.widthAnchor.constraint(equalTo: plusButton.heightAnchor, multiplier: 1).isActive = true
        plusButton.topAnchor.constraint(equalTo: buttonsView.topAnchor).isActive = true
        plusButton.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor).isActive = true
        plusButton.leadingAnchor.constraint(equalTo: buttonsView.centerXAnchor, constant: 10).isActive = true

        minusButton.translatesAutoresizingMaskIntoConstraints = false
        minusButton.widthAnchor.constraint(equalTo: minusButton.heightAnchor, multiplier: 1).isActive = true
        minusButton.topAnchor.constraint(equalTo: buttonsView.topAnchor).isActive = true
        minusButton.bottomAnchor.constraint(equalTo: buttonsView.bottomAnchor).isActive = true
        minusButton.trailingAnchor.constraint(equalTo: buttonsView.centerXAnchor, constant: -10).isActive = true

        addSubview(buttonsStack)

        buttonsStack.translatesAutoresizingMaskIntoConstraints = false
        buttonsStack.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        buttonsStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        buttonsStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        buttonsStack.widthAnchor.constraint(equalToConstant: 100).isActive = true

        buttonsStack.addArrangedSubview(servingLabel)
        buttonsStack.addArrangedSubview(buttonsView)
    }

    private func configureButtons() {
        addSubview(addShoppingButton)
        addShoppingButton.translatesAutoresizingMaskIntoConstraints = false
        addShoppingButton.widthAnchor.constraint(equalTo: addShoppingButton.heightAnchor, multiplier: 1).isActive = true
        addShoppingButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        addShoppingButton.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        addShoppingButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
}
