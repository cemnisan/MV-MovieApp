//
//  TopRatedCell.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 19.05.2022.
//

import UIKit
import MV_Components

final class TopRatedCell: UICollectionViewCell {
    
    private let containerView = UIView()
    private let imageView     = MVImageView(cornerRadius: 10)
    private let rateView      = MVContainerView(backgroundColor: K.Styles.containerViewColor)
    private let rateLogo      = MVLogoImage(image: K.Home.rateLogo,
                                            tintColor: .systemOrange)
    private let rateLabel     = MVSecondaryLabel(textAlignment: .left,
                                                 fontSize: 16,
                                                 textColor: .systemOrange,
                                                 text: nil)
    private let titleLabel    = MVTitleLabel(textAlignment: .left,
                                             fontSize: 18,
                                             textColor: .white)
    private let dateLabel     = MVSecondaryLabel(textAlignment: .left,
                                                 fontSize: 16,
                                                 textColor: .gray,
                                                 text: nil)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        titleLabel.text = nil
        dateLabel.text  = nil
        rateLabel.text  = nil
    }
}

// MARK: - Configure Cell
extension TopRatedCell {
    
    private func configure() {
        configureContainerView()
        configureImageView()
        configureRateElements()
        configureTitleLabel()
        configureCategoryLabel()
    }
    
    private func configureContainerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        containerView.configureConstraints(
            top: (contentView.topAnchor, 0),
            leading: (contentView.leadingAnchor, 0),
            trailing: (contentView.trailingAnchor, 0),
            bottom: (contentView.bottomAnchor, 0))
    }
    
    private func configureImageView() {
        containerView.addSubview(imageView)
        imageView.configureConstraints(
            top: (containerView.topAnchor, 0),
            leading: (containerView.leadingAnchor, 0),
            trailing: (containerView.trailingAnchor, 0))
        imageView.configureHeight(height: contentView.frame.size.height / 1.5)
    }
    
    private func configureRateElements() {
        containerView.addSubview(rateView)
        rateView.configureConstraints(
            top: (containerView.topAnchor, 8),
            trailing: (containerView.trailingAnchor, -8))
        rateView.configureWidth(width: 70)
        rateView.configureHeight(height: 35)
        
        rateView.addSubviews(views: rateLogo, rateLabel)
        rateLogo.configureConstraints(
            leading: (rateView.leadingAnchor, 8),
            centerY: (rateView.centerYAnchor, 0))
        rateLogo.configureWidth(width: 24)
        rateLogo.configureHeight(height: 24)
        
        rateLabel.configureConstraints(
            leading: (rateLogo.trailingAnchor, 4),
            trailing: (rateView.trailingAnchor, -4),
            centerY: (rateLogo.centerYAnchor, 0))
        rateLabel.configureHeight(height: 20)
    }
    
    private func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.configureConstraints(
            top: (imageView.bottomAnchor, 8),
            leading: (contentView.leadingAnchor, 0),
            trailing: (contentView.trailingAnchor, 0))
    }
    
    private func configureCategoryLabel() {
        containerView.addSubview(dateLabel)
        dateLabel.configureConstraints(
            top: (titleLabel.bottomAnchor, 8),
            leading: (contentView.leadingAnchor, 0),
            trailing: (contentView.trailingAnchor, 0))
        dateLabel.configureHeight(height: 20)
    }
}

// MARK: - Set Cell
extension TopRatedCell {
    
    func set(with topRatedMovies: MoviePresentation) {
        let moviePosterPath = "\(K.API.originalImage)\(topRatedMovies.moviePosterPath ?? "")"
        imageView.setImage(with: moviePosterPath)
        titleLabel.text     = topRatedMovies.movieTitle
        rateLabel.text      = "\(topRatedMovies.voteAverage)"
        dateLabel.text      = topRatedMovies.releaseDate
    }
}
