import UIKit
import RxSwift
import RxCocoa

final class IngredientCollectionViewCell: UICollectionViewCell {
    
    var serving = BehaviorRelay<Int>(value: 0)
    
    private var amount: Float = 0
    private var ingredient: Ingredient?
    
    private var disposeBag = DisposeBag()
    
    private let nameLabel: UILabel = {
        return UILabel()
    }()
    
    private let amountLabel: UILabel = {
        return UILabel()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabels()
        bind()
    }
    
    private func bind() {
        serving.map { (val) -> String in
                String(Float(val) * self.amount)
            }.bind(to: amountLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func configure(ingredientAmount: IngredientAmount) {
        self.ingredient = ingredientAmount.ingredient
        self.amount = ingredientAmount.amount
        self.nameLabel.text = ingredient?.name
        self.amountLabel.text = amount.description
    }
    
    private func configureLabels() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameLabel.widthAnchor.constraint(equalToConstant: 100)
            ])
        
        addSubview(amountLabel)
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            amountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            amountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            amountLabel.widthAnchor.constraint(equalToConstant: 100)
            ])
    }
}