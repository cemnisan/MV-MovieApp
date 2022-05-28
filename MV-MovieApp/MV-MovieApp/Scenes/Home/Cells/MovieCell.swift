//
//  MovieCell.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 17.05.2022.
//

import UIKit
import MV_Components

final class MovieCell: UICollectionViewCell {
    
    private let movieImageView = MVImageView(cornerRadius: 10)
    private let containerView  = UIView()
    private let titleView      = UIView()
    private let movieTitle     = MVTitleLabel(textAlignment: .center,
                                              fontSize: 25,
                                              textColor: .white)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        movieImageView.image = nil
        movieTitle.text      = nil
    }
}

// MARK: - Configure Cell
extension MovieCell {
    
    private func configure() {
        configureContainerView()
        configureImageView()
        configureTitleView()
        configureMovieTitle()
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
    
    private func configureImageView() {
        containerView.addSubview(movieImageView)
        movieImageView.configureConstraints(
            top: (containerView.topAnchor, 0),
            leading: (containerView.leadingAnchor, 0),
            trailing: (containerView.trailingAnchor, 0),
            bottom: (containerView.bottomAnchor, 0))
    }
    
    private func configureTitleView() {
        containerView.addSubview(titleView)
        titleView.backgroundColor = K.Styles.containerViewColor
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.configureConstraints(
            leading: (containerView.leadingAnchor, 0),
            trailing: (containerView.trailingAnchor, 0),
            bottom: (containerView.bottomAnchor, 0))
        titleView.configureHeight(height: 50)
    }
    
    private func configureMovieTitle() {
        titleView.addSubview(movieTitle)
        movieTitle.configureConstraints(
            leading: (titleView.leadingAnchor, 8),
            trailing: (titleView.trailingAnchor, -8),
            centerY: (titleView.centerYAnchor, 0))
        movieTitle.configureHeight(height: 25)
    }
}

// MARK: - Set Cell
extension MovieCell {
    func set(with moviePresentation: MoviePresentation) {
        let similarMoviesImage = "\(K.API.w500Image)\(moviePresentation.movieBackgroundPath ?? "")"
        movieImageView.setImage(with: similarMoviesImage)
        movieTitle.text = moviePresentation.movieTitle
    }
}
