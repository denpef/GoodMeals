import RxCocoa
import RxSwift
import UIKit

final class RecipeServingCell: UICollectionViewCell {
    var countOfServing = BehaviorRelay<Int>(value: 2)

    var disposeBag: DisposeBag

    private var countLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let plusButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = UIColor.Common.controlBackground
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitle("+", for: .normal)
        return button
    }()

    private let minusButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = UIColor.Common.controlBackground
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitle("-", for: .normal)
        return button
    }()

    let addToShoppingListButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = UIColor.Common.controlBackground
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Add", for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        disposeBag = DisposeBag()
        super.init(frame: frame)
        configureLabel()
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
        countOfServing.map { String($0) }
            .bind(to: countLabel.rx.text)
            .disposed(by: disposeBag)

        plusButton.rx.tap.subscribe(onNext: {
            self.countOfServing.accept(self.countOfServing.value + 1)
        }).disposed(by: disposeBag)

        minusButton.rx.tap.subscribe(onNext: {
            self.countOfServing.accept(self.countOfServing.value - 1)
        }).disposed(by: disposeBag)
    }

    private func configureLabel() {
        addSubview(countLabel)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([countLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     countLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
                                     countLabel.widthAnchor.constraint(equalToConstant: 100)])
    }

    private func configureButtons() {
        addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([plusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     plusButton.heightAnchor.constraint(equalToConstant: 50),
                                     plusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 132),
                                     plusButton.widthAnchor.constraint(equalToConstant: 50)])

        addSubview(minusButton)
        minusButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([minusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     minusButton.heightAnchor.constraint(equalToConstant: 50),
                                     minusButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 198),
                                     minusButton.widthAnchor.constraint(equalToConstant: 50)])

        addSubview(addToShoppingListButton)
        addToShoppingListButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([addToShoppingListButton.centerYAnchor.constraint(equalTo: centerYAnchor),
                                     addToShoppingListButton.heightAnchor.constraint(equalToConstant: 50),
                                     addToShoppingListButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 260),
                                     addToShoppingListButton.widthAnchor.constraint(equalToConstant: 50)])
    }
}
