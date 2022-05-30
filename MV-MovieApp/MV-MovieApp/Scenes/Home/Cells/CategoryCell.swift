//
//  CategoryCell.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 19.05.2022.
//

import UIKit
import MV_Components

final class CategoryCell: UICollectionViewCell {
    
    private let containerView      = MVContainerView(backgroundColor: K.Styles.childViewsColor)
    private let categoryNameLabel  = MVSecondaryLabel(textAlignment: .center,
                                                      fontSize: 17,
                                                      textColor: .white,
                                                      text: nil)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        categoryNameLabel.text = nil
    }
}

// MARK: - Configure Cell
extension CategoryCell {
    
    private func configure() {
        configureContainerView()
        configureCategoryNameLabel()
    }
    
    private func configureContainerView() {
        contentView.addSubview(containerView)
        containerView.configureConstraints(
            top: (contentView.topAnchor, 0),
            leading: (contentView.leadingAnchor, 0),
            trailing: (contentView.trailingAnchor, 0),
            bottom: (contentView.bottomAnchor, 0))
    }
    
    private func configureCategoryNameLabel() {
        containerView.addSubview(categoryNameLabel)
        categoryNameLabel.configureConstraints(
            centerX: (containerView.centerXAnchor, 0),
            centerY: (containerView.centerYAnchor, 0))
        categoryNameLabel.configureHeight(height: 20)
    }
}

// MARK: - Set Cell
extension CategoryCell {
    func set(with genre: GenrePresentation) {
        categoryNameLabel.text = genre.name
    }
}
