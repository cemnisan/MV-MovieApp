//
//  ActorCell.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 29.05.2022.
//

import UIKit
import MV_Components

final class ActorCell: UICollectionViewCell {
    
    private let containerView  = UIView()
    private let actorImageView = MVImageView(cornerRadius: 10)
    private let actorNameLabel = MVTitleLabel(
        textAlignment: .left,
        fontSize: 20,
        textColor: .white)
    private let actorBornLabel = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 14,
        textColor: K.Styles.globalColor,
        text: nil)
    private let actorBioLabel = MVBodyLabel(textAlignment: .left, textColor: .white)

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure Cell
extension ActorCell {
    
    private func configure() {
        configureContainerView()
        configureActorImageView()
        configureActorNameLabel()
        configureActorBornLabel()
        configureActorBioLabel()
    }
    
    private func configureContainerView() {
        contentView.addSubview(containerView)
        containerView.pinToEdges(of: contentView)
    }
    
    private func configureActorImageView() {
        containerView.addSubview(actorImageView)
        actorImageView.configureConstraints(
            top: (containerView.topAnchor, 0),
            leading: (containerView.leadingAnchor, 0))
        actorImageView.configureWidth(width: contentView.frame.width / 2.3)
        actorImageView.configureHeight(height: contentView.frame.height)
    }
    
    private func configureActorNameLabel() {
        containerView.addSubview(actorNameLabel)
        actorNameLabel.configureConstraints(
            top: (containerView.topAnchor, 0),
            leading: (actorImageView.trailingAnchor, 12),
            trailing: (containerView.trailingAnchor, -4))
        actorNameLabel.configureHeight(height: 25)
    }
        
    private func configureActorBornLabel() {
        containerView.addSubview(actorBornLabel)
        actorBornLabel.configureConstraints(
            top: (actorNameLabel.bottomAnchor, 4),
            leading: (actorImageView.trailingAnchor, 12),
            trailing: (containerView.trailingAnchor, -4))
        actorBornLabel.configureHeight(height: 20)
    }
    
    private func configureActorBioLabel() {
        containerView.addSubview(actorBioLabel)
        actorBioLabel.numberOfLines = 0
        actorBioLabel.configureConstraints(
            top: (actorBornLabel.bottomAnchor, 12),
            leading: (actorImageView.trailingAnchor, 12),
            trailing: (containerView.trailingAnchor, -4),
            bottom: (actorImageView.bottomAnchor, 0))
    }
}

// MARK: - Set Cell
extension ActorCell {
    
    func set(with actorPresentation: ActorDetailPresentation) {
        let actorImageURL   = "https://image.tmdb.org/t/p/original\(actorPresentation.actorPosterPath ?? "")"
        actorImageView.setImage(with: actorImageURL)
        actorBioLabel.text  = actorPresentation.actorBio
        actorBornLabel.text = actorPresentation.actorBorn
        actorNameLabel.text = actorPresentation.actorName
    }
}
