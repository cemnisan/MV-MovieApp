//
//  ProfileViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 7.05.2022.
//

import UIKit
import MV_Components

final class ProfileViewController: UIViewController {
    
    private let userContainerView = MVContainerView(backgroundColor: K.Styles.backgroundColor)
    private let userImageView     = MVUserImage(cornerRadius: 30)
    private let userNameLabel     = MVTitleLabel(textAlignment: .left, fontSize: 20, textColor: .white)
    private let userEmailLabel    = MVTitleLabel(textAlignment: .left, fontSize: 17, textColor: .systemGray2)
    private let userEditButton    = MVButton(image: UIImage(named: "edit")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

extension ProfileViewController {
    
    private func configure() {
        configureViewController()
        configureUserContainerView()
        configureUserImage()
        configureUserEditButton()
        configureUserNameLabel()
        configureUserEmailLabel()
    }
    
    private func configureViewController() {
        title = "Profile"
        view.backgroundColor = K.Styles.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = K.Styles.navTitleColor
    }
    
    private func configureUserContainerView() {
        view.addSubview(userContainerView)
        
        userContainerView.configureConstraints(top: (view.safeAreaLayoutGuide.topAnchor, 24),
                                               leading: (view.leadingAnchor, 24),
                                               trailing: (view.trailingAnchor, -24))
        userContainerView.configureHeight(height: 120)
    }
    
    private func configureUserImage() {
        userContainerView.addSubview(userImageView)
        userImageView.image = UIImage(named: "profilePic")
        
        userImageView.configureConstraints(leading: (userContainerView.leadingAnchor, 8),
                                           centerY: (userContainerView.centerYAnchor, 0))
        userImageView.configureWidth(width: 60)
        userImageView.configureHeight(height: 60)
    }
    
    private func configureUserNameLabel() {
        userContainerView.addSubview(userNameLabel)
        userNameLabel.text = "Cem Nisan"
        
        userNameLabel.configureConstraints(top: (userImageView.topAnchor, 0),
                                           leading: (userImageView.trailingAnchor, 8),
                                           trailing: (userContainerView.trailingAnchor, 8))
        userNameLabel.configureHeight(height: 25)
    }
    
    private func configureUserEmailLabel() {
        userContainerView.addSubview(userEmailLabel)
        userEmailLabel.text = "cnisanbusiness@gmail.com"
        
        userEmailLabel.configureConstraints(top: (userNameLabel.bottomAnchor, 12),
                                            leading: (userImageView.trailingAnchor, 8),
                                            trailing: (userEditButton.leadingAnchor, -8))
        userEmailLabel.configureHeight(height: 20)
    }
    
    private func configureUserEditButton() {
        userContainerView.addSubview(userEditButton)
        userEditButton.addTarget(self,
                                 action: #selector(userDidTappedEditButton),
                                 for: .touchUpInside)
        userEditButton.configureConstraints(trailing: (userContainerView.trailingAnchor, -20),
                                            centerY: (userContainerView.centerYAnchor, 0))
        userEditButton.configureWidth(width: 24)
        userEditButton.configureHeight(height: 24)
    }
}

// MARK: - Button Tapped
extension ProfileViewController {
    
    @objc
    private func userDidTappedEditButton() {
        let view = ProfileEditBuilder.make()
        self.navigationController?.pushViewController(view, animated: true)
    }
}
