//
//  RecipeCell.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/30/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import UIKit

final class RecipeCell: UITableViewCell {
    private let recipeCellView = RecipeCellView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubview(recipeCellView)
        recipeCellView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            recipeCellView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            recipeCellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            recipeCellView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            recipeCellView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
        ])
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with recipe: Recipe?) {
        recipeCellView.configure(with: recipe)
    }
}
