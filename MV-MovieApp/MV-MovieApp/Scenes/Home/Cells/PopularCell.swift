//
//  PopularCell.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 17.05.2022.
//

import UIKit
import MV_Components

final class PopularCell: UICollectionViewCell {
    
    static let cellID = "popularCell"
    
    private let imageView = UIImageView()
    private let containerView = UIView()
    
    private let movieText = MVTitleLabel(
        textAlignment: .center,
        fontSize: 18,
        textColor: .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        movieText.text  = nil
    }
}

// MARK: - Configure
extension PopularCell {
    
    private func configure() {
        configureImageView()
    }
    
    private func configureImageView() {
        contentView.addSubviews(views: containerView, imageView)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(imageView)
        
        containerView.configureConstraints(
            top: (contentView.topAnchor, 0),
            leading: (contentView.leadingAnchor, 0),
            trailing: (contentView.trailingAnchor, 0),
            bottom: (contentView.bottomAnchor, 0))
        imageView.configureConstraints(
            top: (containerView.topAnchor, 0),
            leading: (containerView.leadingAnchor, 0),
            trailing: (containerView.trailingAnchor, 0),
            bottom: (containerView.bottomAnchor, 0))
    }
    
    private func configureMovieText() {
       
    }
}

// MARK: - Set
extension PopularCell {
    
    func set(image: UIImage?,
             text: String) {
        imageView.image = image
        movieText.text  = text
    }
}
