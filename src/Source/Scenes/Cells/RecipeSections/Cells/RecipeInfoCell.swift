import UIKit

final class RecipeInfoCell: UICollectionViewCell {
    let calorificalLabel: UILabel = {
        return UILabel()
    }()
    
    let timeForPreparingLabel: UILabel = {
        return UILabel()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(calorifical: Int, timeForPreparing: String) {
        self.calorificalLabel.text = calorifical.description
        self.timeForPreparingLabel.text = timeForPreparing
    }
    
    private func configureLabels() {
        addSubview(calorificalLabel)
        calorificalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calorificalLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            calorificalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            calorificalLabel.widthAnchor.constraint(equalToConstant: 100)
            ])
        
        addSubview(timeForPreparingLabel)
        timeForPreparingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeForPreparingLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            timeForPreparingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16),
            timeForPreparingLabel.widthAnchor.constraint(equalToConstant: 100)
            ])
    }
}
