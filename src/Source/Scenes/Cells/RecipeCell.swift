//
//  RecipeCell.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/30/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import UIKit

final class RecipeCell: UITableViewCell {
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
        label.font = UIFont.systemFont(ofSize: 24, weight: .light)
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

    private lazy var shadowView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.clipsToBounds = false
        view.layer.masksToBounds = false
        view.layer.shadowOpacity = 0.7
//        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        return view
    }()

    private lazy var titleImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupImageView()
        setupLabels()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupImageView() {
        contentView.addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -70),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 80),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -80),
        ])

        contentView.addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            titleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -70),
            titleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
        ])
    }

    private func setupLabels() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
        ])

        contentView.addSubview(calorificalLabel)
        calorificalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calorificalLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -34),
            calorificalLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            calorificalLabel.heightAnchor.constraint(equalToConstant: 26),
            calorificalLabel.widthAnchor.constraint(equalToConstant: 80),
        ])

        contentView.addSubview(timeForPreparingLabel)
        timeForPreparingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeForPreparingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -34),
            timeForPreparingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            timeForPreparingLabel.heightAnchor.constraint(equalToConstant: 26),
            timeForPreparingLabel.widthAnchor.constraint(equalToConstant: 80),
        ])

        contentView.addSubview(breakfastLabel)
        breakfastLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            breakfastLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -34),
            breakfastLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -50),
            breakfastLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 50),
            breakfastLabel.heightAnchor.constraint(equalToConstant: 26),
        ])
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
