//
//  CategoryCell.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 19.05.2022.
//

import UIKit
import MV_Components

final class CategoryCell: UICollectionViewCell {
    
    static let cellID = "category"
    
    private let containerView = UIView()
    private let categoryName = MVSecondaryLabel(
        textAlignment: .center,
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
        categoryName.text = nil
    }
}

// MARK: - Configure
extension CategoryCell {
    
    private func configure() {
        contentView.addSubview(containerView)
        containerView.backgroundColor = #colorLiteral(red: 0.1927446425, green: 0.2102275491, blue: 0.2745400369, alpha: 1)
        containerView.layer.cornerRadius = 12
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(categoryName)
        
        containerView.configureConstraints(
            top: (contentView.topAnchor, 0),
            leading: (contentView.leadingAnchor, 0),
            trailing: (contentView.trailingAnchor, 0),
            bottom: (contentView.bottomAnchor, 0))
        categoryName.configureConstraints(
            centerX: (containerView.centerXAnchor, 0),
            centerY: (containerView.centerYAnchor, 0))
        categoryName.configureHeight(height: 20)
    }
}

// MARK: - Set
extension CategoryCell {
    
    func set(with genres: GenresPresentation) {
        categoryName.text = genres.name
    }
}
