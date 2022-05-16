//
//  FavoriteCollectionViewCell.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 16.05.2022.
//

import UIKit
import MV_Components

final class FavoriteCollectionViewCell: UICollectionViewCell {
    
    private let movieImage = UIImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        movieImage.image = nil
    }
}

extension FavoriteCollectionViewCell {
    
    private func configure() {
        addSubview(movieImage)
        movieImage.contentMode = .scaleToFill
        movieImage.layer.cornerRadius = 10
        movieImage.clipsToBounds = true
        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieImage.configureConstraints(
            top: (contentView.topAnchor, 0),
            leading: (leadingAnchor, 0),
            trailing: (trailingAnchor, 0))
        movieImage.configureHeight(height: 240)
    }
}

extension FavoriteCollectionViewCell {
    
    func set() {
        movieImage.image = UIImage(named: "movie2")
    }
}
