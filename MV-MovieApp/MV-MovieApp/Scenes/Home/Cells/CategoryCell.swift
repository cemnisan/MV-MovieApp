//
//  CategoryCell.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 19.05.2022.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    static let cellID = "category"
    
    private let containerView = UIView()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CategoryCell {
    
    private func configure() {
        contentView.addSubviews(views: containerView, imageView)
        containerView.backgroundColor = #colorLiteral(red: 0.1927446425, green: 0.2102275491, blue: 0.2745400369, alpha: 1)
        containerView.layer.cornerRadius = 10
        containerView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        
        containerView.configureConstraints(
            top: (contentView.topAnchor, 0),
            leading: (contentView.leadingAnchor, 0),
            trailing: (contentView.trailingAnchor, 0),
            bottom: (contentView.bottomAnchor, 0))
        imageView.configureConstraints(
            centerX: (containerView.centerXAnchor, 0),
            centerY: (containerView.centerYAnchor, 0))
        imageView.configureWidth(width: 30)
        imageView.configureHeight(height: 30)
    }
    
    func set(with carousel: PopularCarouselData) {
        imageView.image = carousel.image
    }
}
