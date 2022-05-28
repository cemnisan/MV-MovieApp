//
//  FavoriteCell.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 16.05.2022.
//

import UIKit
import MV_Components

final class FavoriteCell: UICollectionViewCell {
    
    private let movieImageView = MVImageView(cornerRadius: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        movieImageView.image = nil
    }
}

// MARK: - Configure Cell
extension FavoriteCell {
    private func configure() {
        addSubview(movieImageView)
        movieImageView.configureConstraints(
            top: (contentView.topAnchor, 0),
            leading: (leadingAnchor, 0),
            trailing: (trailingAnchor, 0))
        movieImageView.configureHeight(height: 240)
    }
}

// MARK: - Set Cell
extension FavoriteCell {
    func set() {
        movieImageView.image = UIImage(named: "movie2")
    }
}
