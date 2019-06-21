//
//  RecipeCell.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/30/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import UIKit

final class RecipeCell: UITableViewCell {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private lazy var calorificalLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3049818065)
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var timeForPreparingLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3049818065)
        label.textAlignment = .center
        label.layer.cornerRadius = 15
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var shadowView: UIView = {
        let view = UIView(frame: .zero)
        view.clipsToBounds = false
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize.zero
        view.layer.shadowRadius = 10
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        contentView.addSubview(shadowView)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30)])
        
        shadowView.addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(equalTo: shadowView.topAnchor),
            titleImageView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
            titleImageView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            titleImageView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor)])
    }
    
    private func setupLabels() {
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)])
        
        contentView.addSubview(calorificalLabel)
        calorificalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            calorificalLabel.bottomAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: -10),
            calorificalLabel.leadingAnchor.constraint(equalTo: titleImageView.leadingAnchor, constant: 10),
            calorificalLabel.heightAnchor.constraint(equalToConstant: 30),
            calorificalLabel.widthAnchor.constraint(equalToConstant: 80)])

        contentView.addSubview(timeForPreparingLabel)
        timeForPreparingLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeForPreparingLabel.bottomAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: -10),
            timeForPreparingLabel.trailingAnchor.constraint(equalTo: titleImageView.trailingAnchor, constant: -10),
            timeForPreparingLabel.heightAnchor.constraint(equalToConstant: 30),
            timeForPreparingLabel.widthAnchor.constraint(equalToConstant: 80)])
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
