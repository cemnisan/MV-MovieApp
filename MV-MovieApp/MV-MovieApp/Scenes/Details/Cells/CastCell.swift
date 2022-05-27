//
//  CastCell.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 26.05.2022.
//

import UIKit

final class CastCell: UICollectionViewCell {
    
    private let containerView = UIView()
    private let castImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        castImageView.image = nil
    }
}

extension CastCell {
    
    private func configure() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.configureConstraints(
            top: (contentView.topAnchor, 0),
            leading: (contentView.leadingAnchor, 0),
            trailing: (contentView.trailingAnchor, 0),
            bottom: (contentView.bottomAnchor, 0))
        containerView.addSubview(castImageView)

        castImageView.layer.cornerRadius = contentView.frame.width / 2
        castImageView.clipsToBounds = true
        castImageView.translatesAutoresizingMaskIntoConstraints = false
        castImageView.configureConstraints(
            top: (containerView.topAnchor, 0),
            leading: (containerView.leadingAnchor, 0),
            trailing: (containerView.trailingAnchor, 0),
            bottom: (containerView.bottomAnchor, 0))
    }
}

extension CastCell {
    
    func set(with cast: MovieCastPresentation) {
        castImageView.setImage(with: "\(K.API.w180Image)\(cast.castPosterPath ?? "")")
    }
}
