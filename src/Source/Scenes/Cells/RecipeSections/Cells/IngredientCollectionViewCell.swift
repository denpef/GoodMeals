import UIKit

final class IngredientCollectionViewCell: UICollectionViewCell {
    let nameLabel: UILabel = {
        return UILabel()
    }()
    
    let amountLabel: UILabel = {
        return UILabel()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(ingredientAmount: IngredientAmount) {
        self.nameLabel.text = ingredientAmount.ingredient?.name
        self.amountLabel.text = ingredientAmount.amount.description
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
