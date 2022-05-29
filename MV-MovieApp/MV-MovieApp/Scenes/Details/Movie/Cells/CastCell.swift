//
//  CastCell.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 26.05.2022.
//

import UIKit
import MV_Components

final class CastCell: UICollectionViewCell {
    
    private let containerView = UIView()
    private let castImageView = MVImageView(frame: .zero)
    
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

// MARK: - Configure Cell
extension CastCell {
    
    private func configure() {
        configureContainerView()
        configureCastImageView()
    }
    
    private func configureContainerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.configureConstraints(
            top: (contentView.topAnchor, 0),
            leading: (contentView.leadingAnchor, 0),
            trailing: (contentView.trailingAnchor, 0),
            bottom: (contentView.bottomAnchor, 0))
    }
    
    private func configureCastImageView() {
        containerView.addSubview(castImageView)
        castImageView.layer.cornerRadius = contentView.frame.width / 2
        castImageView.configureConstraints(
            top: (containerView.topAnchor, 0),
            leading: (containerView.leadingAnchor, 0),
            trailing: (containerView.trailingAnchor, 0),
            bottom: (containerView.bottomAnchor, 0))
    }
}

// MARK: - Set Cell
extension CastCell {
    func set(with cast: MovieCastPresentation) {
        let castImage = "\(K.API.w180Image)\(cast.castPosterPath ?? "")"
        castImageView.setImage(with: castImage)
    }
}
