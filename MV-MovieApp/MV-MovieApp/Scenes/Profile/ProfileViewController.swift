//
//  ProfileViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 13.05.2022.
//

import UIKit
import MV_Components

final class ProfileViewController: UIViewController {
    
    private let userBackgroundImage = MVUserImage(frame: .zero)
    private let profileContainerView = MVContainerView(frame: .zero)
    private let userProfileImage    = MVUserImage(cornerRadius: 60)
    private let editProfileButton   = MVButton(
        backgroundColor: K.Styles.backgroundColor,
        title: "Edit Profile",
        cornerRadius: 15)
    private let userFullNameLabel   = MVTitleLabel(
        textAlignment: .left,
        fontSize: 20,
        textColor: .systemBackground)
    private let userNameLabel       = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 15,
        textColor: .systemGray,
        text: nil)
    private let userBioLabel        = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 18,
        textColor: .white,
        text: nil)
    private let calendarImage       = MVLogoImage(
        image: UIImage(systemName: "calendar")!,
        tintColor: .systemGray)
    private let userJoinedLabel     = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 15,
        textColor: .systemGray,
        text: nil)
    
    var profilePresenter: ProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        profilePresenter.loadCurrentUser()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        profilePresenter.loadCurrentUser()
    }
}

extension ProfileViewController {
    
    private func configure() {
        configureViewController()
        configureBackgroundImage()
        configureProfileImage()
        configureEditProfileButton()
        configureUserFullName()
        configureUsernameLabel()
        configureUserBio()
        configureJoinedDateElements()
    }
    
    private func configureViewController() {
        view.backgroundColor = K.Styles.backgroundColor
    }
    
    private func configureBackgroundImage() {
        view.addSubview(userBackgroundImage)
        userBackgroundImage.configureConstraints(
            top: (view.topAnchor, 0),
            leading: (view.leadingAnchor, 0),
            trailing: (view.trailingAnchor, 0))
        userBackgroundImage.configureHeight(height: 240)
    }
    
    private func configureProfileImage() {
        view.addSubviews(views: profileContainerView, userProfileImage)
        profileContainerView.layer.cornerRadius = 60
        profileContainerView.backgroundColor    = K.Styles.backgroundColor
        profileContainerView.configureConstraints(
            leading: (view.leadingAnchor, 16),
            bottom: (userBackgroundImage.bottomAnchor, 60))
        profileContainerView.configureHeight(height: 120)
        profileContainerView.configureWidth(width: 120)
        
        userProfileImage.configureConstraints(
            top: (profileContainerView.topAnchor, 0),
            leading: (profileContainerView.leadingAnchor, 0),
            trailing: (profileContainerView.trailingAnchor, 0),
            bottom: (profileContainerView.bottomAnchor, 0))
    }
    
    private func configureEditProfileButton() {
        view.addSubview(editProfileButton)
        editProfileButton.addTarget(
            self,
            action: #selector(userDidTappedEditProfile),
            for: .touchUpInside)
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.borderColor = UIColor.systemBackground.cgColor
        editProfileButton.configureConstraints(
            top: (userBackgroundImage.bottomAnchor, 16),
            trailing: (view.trailingAnchor, -16))
        editProfileButton.configureWidth(width: 120)
        editProfileButton.configureHeight(height: 35)
    }
    
    private func configureUserFullName() {
        view.addSubview(userFullNameLabel)
        userFullNameLabel.configureConstraints(
            top: (userProfileImage.bottomAnchor, 8),
            leading: (view.leadingAnchor, 16),
            trailing: (view.trailingAnchor, -16))
        userFullNameLabel.configureHeight(height: 30)
    }
    
    private func configureUsernameLabel() {
        view.addSubview(userNameLabel)
        userNameLabel.configureConstraints(
            top: (userFullNameLabel.bottomAnchor, 0),
            leading: (view.leadingAnchor, 16),
            trailing: (view.trailingAnchor, 16))
        userNameLabel.configureHeight(height: 20)
    }
    
    private func configureUserBio() {
        view.addSubview(userBioLabel)
        userBioLabel.text = "Vakti gelince iOS Developer olacağım. I'm a Cameron Fan :p"
        userBioLabel.numberOfLines = 3
        userBioLabel.configureConstraints(
            top: (userNameLabel.bottomAnchor, 8),
            leading: (view.leadingAnchor,16),
            trailing: (view.trailingAnchor, -16))
        userBioLabel.configureHeight(height: 40)
    }
    
    private func configureJoinedDateElements() {
        view.addSubviews(views: calendarImage, userJoinedLabel)
        calendarImage.configureConstraints(
            top: (userBioLabel.bottomAnchor, 8),
            leading: (view.leadingAnchor, 16))
        calendarImage.configureWidth(width: 24)
        calendarImage.configureHeight(height: 24)
        
        userJoinedLabel.text = "Joined August 2021"
        userJoinedLabel.configureConstraints(
            leading: (calendarImage.trailingAnchor, 4),
            trailing: (view.trailingAnchor, -16),
            centerY: (calendarImage.centerYAnchor, 0))
        userJoinedLabel.configureHeight(height: 20)
    }
}

// MARK: - Button Tapped
extension ProfileViewController {
    
    @objc
    private func userDidTappedEditProfile() {
        profilePresenter.editProfileTapped()
    }
}

// MARK: - Presenter Output
extension ProfileViewController: ProfilePresenterOutput {
    
    func showCurrentUser(currentUser: UserPresentation) {
        userProfileImage.setImage(with: currentUser.profilePic!)
        userFullNameLabel.text = currentUser.fullName
        userNameLabel.text     = "@\(currentUser.username!)"
        userBackgroundImage.setImage(with: currentUser.backgroundPic!)
    }
}
