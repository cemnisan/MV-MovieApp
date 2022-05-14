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
    
    private var profilePicker: PHPickerViewController!
    private var backgroundPicker: PHPickerViewController!
    
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
    private let editUsernameLabel = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 17,
        textColor: .white,
        text: "Username")
    private let editUsernameTextField = MVAuthTextField(placeHolder: "Select a username")
    private let editFullNameLabel = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 17,
        textColor: .white,
        text: "Full Name")
    private let editFullNameTextField = MVAuthTextField(frame: .zero)
    private let editEmailLabel = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 17,
        textColor: .white,
        text: "Email")
    private let editEmailTextField = MVAuthTextField(frame: .zero)
    private let saveChangesButton = MVButton(
        backgroundColor: K.Styles.actionButtonColor,
        title: "Save Changes",
        cornerRadius: 20)
    
    var profileEditPresenter: ProfileEditPresenterProtocol!
    
    private var currentUsername: String!
    private var currentFullName: String!
    
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
        configureProgressView()
        configureBackgroundImage()
        configureEditBackgroundImageView()
        configureEditBackgroundImageButton()
        configureUserImage()
        configureEditImageContainerView()
        configureEditImageButton()
        configureEditUsernameElements()
        configureEditFullNameElements()
        configureEditEmailElements()
        configureSaveChangesButton()
    }
    
    private func configureViewController() {
        title                = "Edit Profile"
        view.backgroundColor = K.Styles.backgroundColor
        navigationController?.navigationBar.tintColor = K.Styles.labelTextColor
    }
    
    private func configureProgressView() {
        view.addSubview(progressView)
        progressView.trackTintColor    = .gray
        progressView.progressTintColor = .systemBackground
        progressView.frame             = CGRect(x: 0,
                                                y: 100,
                                                width: view.frame.size.width,
                                                height: 20)
        progressView.isHidden          = true
        progressView.setProgress(0, animated: true)
    }
    
    private func configureBackgroundImage() {
        view.addSubview(currentBackgroundImage)
        currentBackgroundImage.backgroundColor = .darkGray
        currentBackgroundImage.configureConstraints(
            top: (progressView.bottomAnchor, 4),
            leading: (view.leadingAnchor, 0),
            trailing: (view.trailingAnchor, 0))
        currentBackgroundImage.configureHeight(height: 240)
    }
    
    private func configureEditBackgroundImageView() {
        view.addSubview(editBackgroundImageView)
        editBackgroundImageView.layer.cornerRadius = 25
        editBackgroundImageView.configureConstraints(
            centerX: (currentBackgroundImage.centerXAnchor, 0),
            centerY: (currentBackgroundImage.centerYAnchor, 0))
        editBackgroundImageView.configureHeight(height: 50)
        editBackgroundImageView.configureWidth(width: 50)
    }
    
    private func configureEditBackgroundImageButton() {
        view.addSubview(editBackgroundImageButton)
        editBackgroundImageButton.setBackgroundImage(
            UIImage(systemName: "camera"),
            for: .normal)
        editBackgroundImageButton.addTarget(
            self,
            action: #selector(editBackgroundImageButtonTapped),
            for: .touchUpInside)
        editBackgroundImageButton.tintColor = .systemBackground
        editBackgroundImageButton.configureConstraints(
            centerX: (editBackgroundImageView.centerXAnchor, 0),
            centerY: (editBackgroundImageView.centerYAnchor, 0))
        editBackgroundImageButton.configureHeight(height: 25)
        editBackgroundImageButton.configureWidth(width: 25)
    }
    
    private func configureUserImage() {
        view.addSubview(currentProfileImage)
        currentProfileImage.configureConstraints(
            leading: (view.leadingAnchor, 16),
            bottom: (currentBackgroundImage.bottomAnchor, 60))
        currentProfileImage.configureHeight(height: 120)
        currentProfileImage.configureWidth(width: 120)
    }
    
    private func configureEditImageContainerView() {
        view.addSubview(editProfileImageView)
        editProfileImageView.layer.cornerRadius = 16
        
        editProfileImageView.configureConstraints(trailing: (currentProfileImage.trailingAnchor, 4),
                                                    bottom: (currentProfileImage.bottomAnchor, -8))
        editProfileImageView.configureHeight(height: 32)
        editProfileImageView.configureWidth(width: 32)
    }
    
    private func configureEditImageButton() {
        editProfileImageView.addSubview(editProfileImageButton)
        editProfileImageButton.setImage(UIImage(named: "edit2"),
                                 for: .normal)
        editProfileImageButton.addTarget(self,
                                  action: #selector(editImageViewButtonTapped),
                                  for: .touchUpInside)
        editProfileImageButton.configureConstraints(centerX: (editProfileImageView.centerXAnchor, 0),
                                             centerY: (editProfileImageView.centerYAnchor, 0))
        editProfileImageButton.configureHeight(height: 16)
        editProfileImageButton.configureWidth(width: 16)
    }
    
    private func configureEditUsernameElements() {
        [editUsernameLabel,
         editUsernameTextField
        ].forEach {
            view.addSubview($0)
            $0.configureConstraints(leading: (view.leadingAnchor, 24),
                                    trailing: (view.trailingAnchor, -24))
        }
        editUsernameLabel.configureConstraints(top: (currentProfileImage.bottomAnchor, 16))
        editUsernameLabel.configureHeight(height: 25)
        
        editUsernameTextField.delegate = self
        editUsernameTextField.configureConstraints(top: (editUsernameLabel.bottomAnchor, 8))
        editUsernameTextField.configureHeight(height: 40)
    }
    
    private func configureEditFullNameElements() {
        [editFullNameLabel,
         editFullNameTextField
        ].forEach {
            view.addSubview($0)
            $0.configureConstraints(leading: (view.leadingAnchor, 24),
                                    trailing: (view.trailingAnchor, -24))
        }
        editFullNameLabel.configureConstraints(top: (editUsernameTextField.bottomAnchor, 24))
        editFullNameLabel.configureHeight(height: 25)
        
        editFullNameTextField.delegate = self
        editFullNameTextField.configureConstraints(top: (editFullNameLabel.bottomAnchor, 8))
        editFullNameTextField.configureHeight(height: 40)
    }
    
    private func configureEditEmailElements() {
        [editEmailLabel,
         editEmailTextField
        ].forEach {
            view.addSubview($0)
            $0.configureConstraints(leading: (view.leadingAnchor, 24),
                                    trailing: (view.trailingAnchor, -24))
        }
        editEmailLabel.configureConstraints(top: (editFullNameTextField.bottomAnchor, 24))
        editEmailLabel.configureHeight(height: 25)
        
        editEmailTextField.isEnabled       = false
        editEmailTextField.backgroundColor = .darkGray
        editEmailTextField.configureConstraints(top: (editEmailLabel.bottomAnchor, 8))
        editEmailTextField.configureHeight(height: 40)
    }
    
    private func configureSaveChangesButton() {
        view.addSubview(saveChangesButton)
        configureSaveChangesButton(isEnabled: false)
        saveChangesButton.addTarget(self,
                                    action: #selector(saveChangesButtonTapped),
                                    for: .touchUpInside)
        saveChangesButton.configureConstraints(top: (editEmailTextField.bottomAnchor, 40),
                                               leading: (view.leadingAnchor, 24),
                                               trailing: (view.trailingAnchor, -24))
        saveChangesButton.configureHeight(height: 55)
    }
    
    private func configureSaveChangesButton(isEnabled: Bool) {
        saveChangesButton.isEnabled = isEnabled
        
        if isEnabled {
            saveChangesButton.backgroundColor = K.Styles.actionButtonColor
        }
        else {
            saveChangesButton.backgroundColor = .darkGray
        }
    }
    
    private func configurePHPicker(with selectPicker: SelectPickerView) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = PHPickerFilter.images
        
        switch selectPicker {
        case .profilePic:
            profilePicker = PHPickerViewController(configuration: config)
            profilePicker.delegate = self
            self.present(profilePicker, animated: true)
        case .backgroundPic:
            backgroundPicker = PHPickerViewController(configuration: config)
            backgroundPicker.delegate = self
            self.present(backgroundPicker, animated: true)
        }
    }
}

// MARK: - Button Tapped
extension ProfileEditViewController {
    
    @objc
    private func editImageViewButtonTapped() {
        configurePHPicker(with: .profilePic)
    }
    
    @objc
    private func editBackgroundImageButtonTapped() {
        configurePHPicker(with: .backgroundPic)
    }
    
    @objc
    private func saveChangesButtonTapped() {
        guard let fullName = editFullNameTextField.text,
              let username = editUsernameTextField.text else { return }
        profileEditPresenter.updateUser(with: fullName, username: username)
    }
}

// MARK: - UITextField Delegate
extension ProfileEditViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if currentUsername != editUsernameTextField.text ||
           currentFullName != editFullNameTextField.text
        {
            configureSaveChangesButton(isEnabled: true)
        } else {
            configureSaveChangesButton(isEnabled: false)
        }
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
                          let image = object as? UIImage,
                          let imageData = image.jpegData(compressionQuality: 0.3) else { return }
                    self.uploadImage(on: picker, image: image, imageData: imageData)
            }
        }
    }
}

// MARK: - Upload Profile, Background Image
extension ProfileEditViewController {
    
    private func uploadImage(on selectedPicker: PHPickerViewController,
                                       image: UIImage,
                                       imageData: Data) {
        if selectedPicker == profilePicker {
            DispatchQueue.main.async {
                self.currentProfileImage.image = image
                self.configureSaveChangesButton(isEnabled: false)
                self.editProfileImageButton.isEnabled = false
            }
            profileEditPresenter.uploadImage(selectedPicker: .profilePic, image: imageData)
        } else {
            DispatchQueue.main.async {
                self.currentBackgroundImage.image = image
                self.configureSaveChangesButton(isEnabled: false)
                self.editBackgroundImageButton.isEnabled = false
            }
            profileEditPresenter.uploadImage(selectedPicker: .backgroundPic, image: imageData)
        }
    }
}

// MARK: - Profile Edit Presenter Output
extension ProfileEditViewController: ProfileEditPresenterOutput {
 
    func showCurrentUser(currentUser: UserPresentation) {
        
        currentBackgroundImage.setImage(with: currentUser.backgroundPic ?? "")
        currentProfileImage.setImage(with: currentUser.profilePic ?? "")
        
        currentNameLabel.text      = currentUser.fullName
        currentEmailLabel.text     = currentUser.email
        
        editEmailTextField.text    = currentUser.email
        editFullNameTextField.text = currentUser.fullName
        editUsernameTextField.text = currentUser.username
        
        currentUsername            = currentUser.username
        currentFullName            = currentUser.fullName
    }
 
    func showUpdatedImage(with url: String,
                          selectedPicker: SelectPickerView) {
        switch selectedPicker {
        case .profilePic:
            currentProfileImage.setImage(with: url)
            editProfileImageButton.isEnabled = true
        case .backgroundPic:
            currentBackgroundImage.setImage(with: url)
            editBackgroundImageButton.isEnabled = true
        }
        
        configureSaveChangesButton(isEnabled: true)
        progressView.isHidden     = true
        progressView.setProgress(0, animated: true)
    }
    
    func initializeProgress(progress: Float?) {
        if let progress = progress {
            progressView.isHidden = false
            progressView.setProgress(progress / 100, animated: true)
        }
    }
        
    func showError(error: Error) {
        showErrorAlert(with: "Something went wrong",
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
