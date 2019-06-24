import UIKit

final class RecipeCellView: UIView {
    private lazy var breakfastLabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
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
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2981592466)
        label.textAlignment = .center
        label.layer.cornerRadius = 13
        label.clipsToBounds = true
        return label
    }()

    private lazy var timeForPreparingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2981592466)
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
        layer.shadowRadius = 6
        layer.cornerRadius = 13
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageView() {
        addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([titleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 38),
                                     titleImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -42),
                                     titleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                                     titleImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)])
    }

    private func setupLabels() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                                     titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                                     titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                                     titleLabel.heightAnchor.constraint(equalToConstant: 24)])

        addSubview(calorificalLabel)
        calorificalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([calorificalLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                                     calorificalLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                                     calorificalLabel.heightAnchor.constraint(equalToConstant: 26),
                                     calorificalLabel.widthAnchor.constraint(equalToConstant: 80)])

        addSubview(timeForPreparingLabel)
        timeForPreparingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([timeForPreparingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                                     timeForPreparingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
                                     timeForPreparingLabel.heightAnchor.constraint(equalToConstant: 26),
                                     timeForPreparingLabel.widthAnchor.constraint(equalToConstant: 80)])

        addSubview(breakfastLabel)
        breakfastLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([breakfastLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                                     breakfastLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
                                     breakfastLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
                                     breakfastLabel.heightAnchor.constraint(equalToConstant: 26)])
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
