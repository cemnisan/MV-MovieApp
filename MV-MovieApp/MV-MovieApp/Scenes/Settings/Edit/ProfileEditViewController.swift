//
//  ProfileEditViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 9.05.2022.
//

import UIKit
import PhotosUI
import MV_Components

final class ProfileEditViewController: BaseViewController {
    
    private let contentView               = UIView()
    private let scrollView                = UIScrollView()
    
    private let progressView              = UIProgressView(progressViewStyle: .bar)
    private let currentBackgroundImage    = MVUserImage(frame: .zero)
    private let editBackgroundImageView   = MVContainerView(backgroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5952762831))
    private let editBackgroundImageButton = MVButton(frame: .zero)
    private let currentProfileImage       = MVUserImage(cornerRadius: 60)
    private let editProfileImageView      = MVContainerView(backgroundColor: K.Styles.backgroundColor)
    private let editProfileImageButton    = MVButton(frame: .zero)
    
    private let currentNameLabel = MVTitleLabel(
        textAlignment: .left,
        fontSize: 24,
        textColor: .white)
    private let currentEmailLabel = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 20,
        textColor: .systemGray,
        text: nil)
    private let usernameForm = MVForm(
        frame: .zero,
        label: "Username",
        placeHolder: "Select a Username",
        height: 40)
    private let fullNameForm = MVForm(
        frame: .zero,
        label: "Full Name",
        placeHolder: "Select a Full name",
        height: 40)
    private let emailForm = MVForm(
        frame: .zero,
        label: "Email",
        placeHolder: "Select a E-mail",
        height: 40)
    private let saveChangesButton = MVButton(
        backgroundColor: K.Styles.actionButtonColor,
        title: "Save Changes",
        cornerRadius: 20)
    
    private let formStackView = MVFormStackView(stackSpacing: 24)
    
    var profileEditPresenter: ProfileEditPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        profileEditPresenter.loadCurrentUser()
    }
}

// MARK: - Configure
extension ProfileEditViewController {
    
    private func configure() {
        configureViewController()
        createDismissKeyboardTapGesture()
        configureScrollView()
        configureProgressView()
        configureBackgroundImage()
        configureEditBackgroundImageView()
        configureEditBackgroundImageButton()
        configureUserImage()
        configureEditImageContainerView()
        configureEditImageButton()
        configureFormElements()
        configureSaveChangesButton()
    }
    
    private func configureViewController() {
        title = "Edit Profile"
    }
    
    private func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        contentView.configureWidth(anchor: scrollView.widthAnchor)
        contentView.configureHeight(height: 700)
    }
    
    private func configureProgressView() {
        contentView.addSubview(progressView)
        progressView.trackTintColor    = .gray
        progressView.progressTintColor = .systemBackground
        progressView.frame = CGRect(
            x: 0,
            y: 10,
            width: view.frame.size.width,
            height: 20)
        progressView.isHidden = true
        progressView.setProgress(0, animated: true)
    }
    
    private func configureBackgroundImage() {
        contentView.addSubview(currentBackgroundImage)
        currentBackgroundImage.backgroundColor = .darkGray
        currentBackgroundImage.configureConstraints(
            top: (progressView.bottomAnchor, 4),
            leading: (contentView.leadingAnchor, 0),
            trailing: (contentView.trailingAnchor, 0))
        currentBackgroundImage.configureHeight(height: 240)
    }
    
    private func configureEditBackgroundImageView() {
        contentView.addSubview(editBackgroundImageView)
        editBackgroundImageView.layer.cornerRadius = 25
        editBackgroundImageView.configureConstraints(
            centerX: (currentBackgroundImage.centerXAnchor, 0),
            centerY: (currentBackgroundImage.centerYAnchor, 0))
        editBackgroundImageView.configureHeight(height: 50)
        editBackgroundImageView.configureWidth(width: 50)
    }
    
    private func configureEditBackgroundImageButton() {
        contentView.addSubview(editBackgroundImageButton)
        editBackgroundImageButton.setBackgroundImage(
            UIImage(systemName: "camera"),
            for: .normal)
        editBackgroundImageButton.addTarget(
            self,
            action: #selector(editBackgroundPictureButtonTapped),
            for: .touchUpInside)
        editBackgroundImageButton.tintColor = .systemBackground
        editBackgroundImageButton.configureConstraints(
            centerX: (editBackgroundImageView.centerXAnchor, 0),
            centerY: (editBackgroundImageView.centerYAnchor, 0))
        editBackgroundImageButton.configureHeight(height: 25)
        editBackgroundImageButton.configureWidth(width: 25)
    }
    
    private func configureUserImage() {
        contentView.addSubview(currentProfileImage)
        currentProfileImage.configureConstraints(
            leading: (contentView.leadingAnchor, 16),
            bottom: (currentBackgroundImage.bottomAnchor, 60))
        currentProfileImage.configureHeight(height: 120)
        currentProfileImage.configureWidth(width: 120)
    }
    
    private func configureEditImageContainerView() {
        contentView.addSubview(editProfileImageView)
        editProfileImageView.layer.cornerRadius = 16
        
        editProfileImageView.configureConstraints(
            trailing: (currentProfileImage.trailingAnchor, 4),
            bottom: (currentProfileImage.bottomAnchor, -8))
        editProfileImageView.configureHeight(height: 32)
        editProfileImageView.configureWidth(width: 32)
    }
    
    private func configureEditImageButton() {
        editProfileImageView.addSubview(editProfileImageButton)
        editProfileImageButton.setImage(
            UIImage(named: "edit2"),
            for: .normal)
        editProfileImageButton.addTarget(
            self,
            action: #selector(editProfilePictureButtonTapped),
            for: .touchUpInside)
        editProfileImageButton.configureConstraints(
            centerX: (editProfileImageView.centerXAnchor, 0),
            centerY: (editProfileImageView.centerYAnchor, 0))
        editProfileImageButton.configureHeight(height: 16)
        editProfileImageButton.configureWidth(width: 16)
    }
    
    private func configureFormElements() {
        emailForm.formTextField.isEnabled       = false
        emailForm.formTextField.backgroundColor = .darkGray
        usernameForm.formTextField.delegate     = self
        fullNameForm.formTextField.delegate     = self
        
        [usernameForm,
         fullNameForm,
         emailForm
        ].forEach { formStackView.addArrangedSubview($0) }
        contentView.addSubview(formStackView)
        
        formStackView.configureConstraints(
            top: (currentProfileImage.bottomAnchor, 16),
            leading: (contentView.leadingAnchor, 24),
            trailing: (contentView.trailingAnchor, -24))
        formStackView.configureHeight(height: 245)
    }
    
    private func configureSaveChangesButton() {
        contentView.addSubview(saveChangesButton)
        configureSaveChangesButton(isEnabled: false)
        saveChangesButton.addTarget(
            self,
            action: #selector(saveChangesButtonTapped),
            for: .touchUpInside)
        saveChangesButton.configureConstraints(
            top: (formStackView.bottomAnchor, 40),
            leading: (contentView.leadingAnchor, 24),
            trailing: (contentView.trailingAnchor, -24))
        saveChangesButton.configureHeight(height: 55)
    }
    
    private func configureSaveChangesButton(isEnabled: Bool) {
        saveChangesButton.isEnabled = isEnabled
        
        if isEnabled { saveChangesButton.backgroundColor = K.Styles.actionButtonColor }
        else { saveChangesButton.backgroundColor = .darkGray }
    }
}

// MARK: - Button Tapped
extension ProfileEditViewController {
    
    @objc
    private func editProfilePictureButtonTapped() {
        profileEditPresenter.choosePictureButtonTapped(on: .profilePic, delegate: self)
    }
    
    @objc
    private func editBackgroundPictureButtonTapped() {
        profileEditPresenter.choosePictureButtonTapped(on: .backgroundPic, delegate: self)
    }
    
    @objc
    private func saveChangesButtonTapped() {
        guard let fullName = fullNameForm.formTextField.text,
              let username = usernameForm.formTextField.text else { return }
        profileEditPresenter.updateUser(with: fullName, username: username)
    }
}

// MARK: - UITextField Delegate
extension ProfileEditViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let isTextFieldsChanged = profileEditPresenter.isTextFieldsChanged(
            for: usernameForm.formTextField.text!,
            fullNameText: fullNameForm.formTextField.text!)
        configureSaveChangesButton(isEnabled: isTextFieldsChanged)
    }
}

// MARK: - PHPicker Delegate
extension ProfileEditViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController,
                didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        for result in results {
            result.itemProvider
                .loadObject(ofClass: UIImage.self) { [weak self] (object, error) in
                    guard let self  = self,
                          let picture = object as? UIImage,
                          let pictureData = picture.jpegData(compressionQuality: 0.3) else { return }
                    self.profileEditPresenter.chosenPicture(
                        on: picker,
                        picture: picture,
                        pictureData: pictureData)
                }
        }
    }
}

// MARK: - Profile Edit Presenter Output
extension ProfileEditViewController: ProfileEditPresenterOutput {
    
    func showCurrentUser(currentUser: UserPresentation) {
        currentBackgroundImage.setImage(with: currentUser.backgroundPic)
        currentProfileImage.setImage(with: currentUser.profilePic)
        
        currentNameLabel.text      = currentUser.fullName
        currentEmailLabel.text     = currentUser.email
        
        usernameForm.formTextField.text = currentUser.username
        fullNameForm.formTextField.text = currentUser.fullName
        emailForm.formTextField.text    = currentUser.email
    }
    
    func showChosenPictures(chosenProfilePic: UIImage? = nil,
                            chosenBackgroundPic: UIImage? = nil) {
        if let chosenProfilePic = chosenProfilePic {
            currentProfileImage.image = chosenProfilePic
        }
        
        if let chosenBackgroundPic = chosenBackgroundPic {
            currentBackgroundImage.image = chosenBackgroundPic
        }
        
        editProfileImageButton.isEnabled    = false
        editBackgroundImageButton.isEnabled = false
        configureSaveChangesButton(isEnabled: false)
    }
    
    func showStartedProgress(progress: Float) {
        progressView.isHidden = false
        progressView.setProgress(progress / 100, animated: true)
    }
    
    func showUpdatedPictures(profileUrl: String?    = nil,
                             backgroundUrl: String? = nil) {
        if let profileUrl = profileUrl {
            currentProfileImage.setImage(with: profileUrl)
        }
        
        if let backgroundUrl = backgroundUrl {
            currentBackgroundImage.setImage(with: backgroundUrl)
        }
        
        progressView.isHidden = true
        progressView.setProgress(0, animated: true)
        
        editProfileImageButton.isEnabled    = true
        editBackgroundImageButton.isEnabled = true
        configureSaveChangesButton(isEnabled: true)
    }
    
    func showError(error: Error) {
        showAlert(
            type: .info,
            title: "Something Went Wrong",
            message: error.localizedDescription,
            buttonTitle: "OK")
    }
    
    func displayLoading() {
        configureSaveChangesButton(isEnabled: false)
        showLoadingView()
    }
    
    func dismissLoading() {
        dismissLoadingView()
    }
}
