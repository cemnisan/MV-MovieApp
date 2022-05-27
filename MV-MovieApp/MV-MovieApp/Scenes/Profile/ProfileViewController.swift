//
//  ProfileViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 13.05.2022.
//

import UIKit
import MV_Components

final class ProfileViewController: BaseViewController {
    
    private let userBackgroundImage = MVImageView(frame: .zero)
    private let profileContainerView = MVContainerView(frame: .zero)
    private let userProfileImage    = MVImageView(cornerRadius: 60)
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
    private let totalWatchedFlimsLabel = MVTitleLabel(
        textAlignment: .center,
        fontSize: 20,
        textColor: .white)
    private let watchedFlimsLabel = MVSecondaryLabel(
        textAlignment: .center,
        fontSize: 17,
        textColor: .systemGray,
        text: nil)
    private let totalWatchListLabel = MVTitleLabel(
        textAlignment: .center,
        fontSize: 20,
        textColor: .white)
    private let watchListLabel = MVSecondaryLabel(
        textAlignment: .center,
        fontSize: 17,
        textColor: .systemGray,
        text: nil)
    private let totalFollowersLabel = MVTitleLabel(
        textAlignment: .center,
        fontSize: 20,
        textColor: .white)
    private let followersLabel = MVSecondaryLabel(
        textAlignment: .center,
        fontSize: 17,
        textColor: .systemGray,
        text: nil)
    private let totalFollowingLabel = MVTitleLabel(
        textAlignment: .center,
        fontSize: 20,
        textColor: .white)
    private let followingLabel = MVSecondaryLabel(
        textAlignment: .center,
        fontSize: 17,
        textColor: .systemGray,
        text: nil)
    private let simpleLine = MVSimpleLine(frame: .zero)
    private let favoriteFlimsLabel = MVTitleLabel(
        textAlignment: .left,
        fontSize: 22,
        textColor: .systemBackground)
    private var favoriteCollectionView: UICollectionView!
    
    var profilePresenter: ProfilePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        profilePresenter.loadCurrentUser()
    }
}

// MARK: - Configure UI
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
        configureUserWatchInfo()
        configureSimpleLine()
        configureFavoriteFlimsLabel()
        configureFavoriteCollectionView()
    }
    
    private func configureViewController() {
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
        editProfileButton.isEnabled = false
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
    
    private func configureWatchedFlimsElements() -> UIStackView {
        totalWatchedFlimsLabel.text = "3,812"
        watchedFlimsLabel.text      = "Flims"
        
        let stackView = UIStackView(arrangedSubviews: [totalWatchedFlimsLabel, watchedFlimsLabel])
        stackView.distribution = .fillEqually
        stackView.spacing      = 4
        stackView.axis         = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubviews(views: stackView)
        
        stackView.configureHeight(height: 45)
        
        return stackView
    }
    
    private func configureWatchListElements() -> UIStackView {
        totalWatchListLabel.text = "102"
        watchListLabel.text      = "List"
        
        let stackView = UIStackView(arrangedSubviews: [totalWatchListLabel, watchListLabel])
        stackView.distribution = .fillEqually
        stackView.spacing      = 4
        stackView.axis         = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.configureHeight(height: 45)
        
        return stackView
    }
    
    private func configureFollowersElements() -> UIStackView {
        totalFollowersLabel.text = "102"
        followersLabel.text      = "Followers"
        
        let stackView = UIStackView(arrangedSubviews: [totalFollowersLabel, followersLabel])
        stackView.distribution = .fillEqually
        stackView.spacing      = 4
        stackView.axis         = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.configureHeight(height: 45)
        
        return stackView
    }
    
    private func configureFollowingElements() -> UIStackView {
        totalFollowingLabel.text = "102"
        followingLabel.text      = "Following"
        
        let stackView = UIStackView(arrangedSubviews: [totalFollowingLabel, followingLabel])
        stackView.distribution = .fillEqually
        stackView.spacing      = 4
        stackView.axis         = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.configureHeight(height: 45)
        
        return stackView
    }
    
    private func configureUserWatchInfo() {
        let stackView = UIStackView(arrangedSubviews: [
            configureWatchedFlimsElements(),
            configureWatchListElements(),
            configureFollowersElements(),
            configureFollowingElements()])
        stackView.distribution = .equalSpacing
        stackView.axis         = .horizontal
        stackView.spacing      = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.configureConstraints(
            top: (userJoinedLabel.bottomAnchor, 16),
            leading: (view.leadingAnchor, 16),
            trailing: (view.trailingAnchor, -16))
        stackView.configureHeight(height: 45)
    }
    
    private func configureSimpleLine() {
        view.addSubview(simpleLine)
        simpleLine.configureConstraints(
            top: (followingLabel.bottomAnchor, 4),
            leading: (view.leadingAnchor, 16),
            trailing: (view.trailingAnchor, -16))
        simpleLine.configureHeight(height: 0.5)
    }
    
    private func configureFavoriteFlimsLabel() {
        view.addSubview(favoriteFlimsLabel)
        favoriteFlimsLabel.text = "Favorite Flims"
        favoriteFlimsLabel.configureConstraints(
            top: (simpleLine.bottomAnchor, 16),
            leading: (view.leadingAnchor, 16),
            trailing: (view.trailingAnchor, -16))
        favoriteFlimsLabel.configureHeight(height: 25)
    }
    
    private func configureFavoriteCollectionView() {
        favoriteCollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createFlowLayout())
        view.addSubview(favoriteCollectionView)
        favoriteCollectionView.configureConstraints(
            top: (favoriteFlimsLabel.bottomAnchor, 8),
            leading: (view.leadingAnchor, 16),
            trailing: (view.trailingAnchor, -16),
            bottom: (view.bottomAnchor, -8))
        favoriteCollectionView.register(
            FavoriteCollectionViewCell.self,
            forCellWithReuseIdentifier: "favoriteCell")
        favoriteCollectionView.backgroundColor = K.Styles.backgroundColor
        favoriteCollectionView.delegate   = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func createFlowLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width / 2.5, height: 320)
        layout.minimumLineSpacing = 8
        
        return layout
    }
}

// MARK: - Button Tapped
extension ProfileViewController {
    
    @objc
    private func userDidTappedEditProfile() {
        profilePresenter.editProfileTapped()
    }
    
    @objc
    private func segmentValueChanged() {}
}

// MARK: - Presenter Output
extension ProfileViewController: ProfilePresenterOutput {
    
    func displayLoading() {
        editProfileButton.isEnabled = false
    }
    
    func dismissLoading() {
        editProfileButton.isEnabled = true
    }
    
    func showCurrentUser(currentUser: UserPresentation) {
        userProfileImage.setImage(with: currentUser.profilePic)
        userFullNameLabel.text = currentUser.fullName
        userNameLabel.text     = "@\(currentUser.username)"
        userBackgroundImage.setImage(with: currentUser.backgroundPic)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "favoriteCell",
            for: indexPath) as! FavoriteCollectionViewCell
        cell.set()
        return cell
    }
}

extension ProfileViewController: UICollectionViewDelegate {}
