import UIKit

final class RecipeCellView: UIView {
    private lazy var breakfastLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.Common.subtitleLabelText
        label.textAlignment = .center
        label.text = "Breakfast"
        label.font = UIFont.systemFont(ofSize: 16, weight: .light)
        return label
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 20, weight: .light)
        return label
    }()

    private lazy var calorificalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .white
        label.backgroundColor = UIColor.Common.infoLabelText
        label.textAlignment = .center
        label.layer.cornerRadius = 13
        label.clipsToBounds = true
        return label
    }()

    private lazy var timeForPreparingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .white
        label.backgroundColor = UIColor.Common.infoLabelText
        label.textAlignment = .center
        label.layer.cornerRadius = 13
        label.clipsToBounds = true
        return label
    }()

    private lazy var titleImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupLabels()
        backgroundColor = .white
        clipsToBounds = false
        layer.masksToBounds = false
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.shadowRadius = 4
        layer.cornerRadius = 8
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageView() {
        addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 38).isActive = true
        titleImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -42).isActive = true
        titleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        titleImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }

    private func setupLabels() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true

        addSubview(calorificalLabel)
        calorificalLabel.translatesAutoresizingMaskIntoConstraints = false
        calorificalLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        calorificalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        calorificalLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        calorificalLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true

        addSubview(timeForPreparingLabel)
        timeForPreparingLabel.translatesAutoresizingMaskIntoConstraints = false
        timeForPreparingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        timeForPreparingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        timeForPreparingLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
        timeForPreparingLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true

        addSubview(breakfastLabel)
        breakfastLabel.translatesAutoresizingMaskIntoConstraints = false
        breakfastLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
        breakfastLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50).isActive = true
        breakfastLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50).isActive = true
        breakfastLabel.heightAnchor.constraint(equalToConstant: 26).isActive = true
    }

    func configure(with recipe: Recipe?) {
        if let recipe = recipe {
            titleImageView.loadImage(from: recipe.image)
            calorificalLabel.text = "\(recipe.calorific.description) kcal"
            timeForPreparingLabel.text = "\(recipe.timeForPreparing.description)"
            titleLabel.text = recipe.name
        }
    }
}
