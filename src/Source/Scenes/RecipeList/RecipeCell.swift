//
//  RecipeCell.swift
//  GoodMeals
//
//  Created by Denis Efimov on 5/30/19.
//  Copyright © 2019 Denis Efimov. All rights reserved.
//

import UIKit

final class RecipeCell: UITableViewCell {
    
    private lazy var titleImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupImageView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupImageView() {
        contentView.addSubview(titleImageView)
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([titleImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                                     titleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
                                     titleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                                     titleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)])
    }
    
    func configure(with recipe: Recipe?) {
        if let imagePath = recipe?.image {
            titleImageView.loadImage(from: imagePath)
        }
    }
}
