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
    
    private let progressView           = UIProgressView(progressViewStyle: .bar)
    
    private let currentImageView       = MVUserImage(cornerRadius: 60)
    private let editImageContainerView = MVContainerView(backgroundColor: K.Styles.backgroundColor)
    private let editImageButton        = MVButton(frame: .zero)
    
    private let currentNameLabel = MVTitleLabel(
        textAlignment: .center,
        fontSize: 24,
        textColor: .white)
    private let currentEmailLabel = MVSecondaryLabel(
        textAlignment: .center,
        fontSize: 20,
        textColor: .systemGray,
        text: nil)
    
    private let editUsernameLabel = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 17,
        textColor: .white,
        text: "Username")
    private let editUsernameTextField = MVAuthenticatesTextField(placeHolder: "Select a username")
    
    private let editFullNameLabel = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 17,
        textColor: .white,
        text: "Full Name")
    private let editFullNameTextField = MVAuthenticatesTextField(frame: .zero)
    
    private let editEmailLabel = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 17,
        textColor: .white,
        text: "Email")
    private let editEmailTextField = MVAuthenticatesTextField(frame: .zero)
    
    private let saveChangesButton = MVButton(
        backgroundColor: K.Styles.actionButtonColor,
        title: "Save Changes",
        cornerRadius: 20)
    
    var profileEditPresenter: ProfileEditPresenterProtocol!
    
    var currentUsername: String!
    var currentFullName: String!
    
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
        configureUserImage()
        configureEditImageContainerView()
        configureEditImageButton()
        configureUserNameLabel()
        configureUserEmailLabel()
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
        view.addSubviews(views: progressView)
        progressView.trackTintColor    = .gray
        progressView.progressTintColor = .darkGray
        progressView.frame             = CGRect(x: 10,
                                                y: 100,
                                                width: view.frame.size.width - 20,
                                                height: 20)
        progressView.isHidden          = true
        progressView.setProgress(0, animated: true)
    }
    
    private func configureUserImage() {
        view.addSubview(currentImageView)
        
        currentImageView.configureConstraints(top: (progressView.bottomAnchor, 8),
                                              centerX: (view.centerXAnchor, 0))
        currentImageView.configureHeight(height: 120)
        currentImageView.configureWidth(width: 120)
    }
    
    private func configureEditImageContainerView() {
        view.addSubview(editImageContainerView)
        editImageContainerView.layer.cornerRadius = 16
        
        editImageContainerView.configureConstraints(trailing: (currentImageView.trailingAnchor, 4),
                                                    bottom: (currentImageView.bottomAnchor, -8))
        editImageContainerView.configureHeight(height: 32)
        editImageContainerView.configureWidth(width: 32)
    }
    
    private func configureEditImageButton() {
        editImageContainerView.addSubview(editImageButton)
        editImageButton.setImage(UIImage(named: "edit2"),
                                 for: .normal)
        editImageButton.addTarget(self,
                                  action: #selector(editImageViewButtonTapped),
                                  for: .touchUpInside)
        editImageButton.configureConstraints(centerX: (editImageContainerView.centerXAnchor, 0),
                                             centerY: (editImageContainerView.centerYAnchor, 0))
        editImageButton.configureHeight(height: 16)
        editImageButton.configureWidth(width: 16)
    }
    
    private func configureUserNameLabel() {
        view.addSubview(currentNameLabel)
        currentNameLabel.configureConstraints(top: (currentImageView.bottomAnchor, 16),
                                              leading: (view.leadingAnchor, 24),
                                              trailing: (view.trailingAnchor, -24))
        currentNameLabel.configureHeight(height: 25)
    }
    
    private func configureUserEmailLabel() {
        view.addSubview(currentEmailLabel)
        
        currentEmailLabel.configureConstraints(top: (currentNameLabel.bottomAnchor, 8),
                                               leading: (view.leadingAnchor, 24),
                                               trailing: (view.trailingAnchor, -24))
        currentEmailLabel.configureHeight(height: 20)
    }
    
    private func configureEditUsernameElements() {
        [editUsernameLabel,
         editUsernameTextField
        ].forEach {
            view.addSubview($0)
            $0.configureConstraints(leading: (view.leadingAnchor, 24),
                                    trailing: (view.trailingAnchor, -24))
        }
        editUsernameLabel.configureConstraints(top: (currentEmailLabel.bottomAnchor, 40))
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
        
        configureSaveChangesButton(for: false)
        saveChangesButton.addTarget(self,
                                    action: #selector(saveChangesButtonTapped),
                                    for: .touchUpInside)
        saveChangesButton.configureConstraints(top: (editEmailTextField.bottomAnchor, 40),
                                               leading: (view.leadingAnchor, 24),
                                               trailing: (view.trailingAnchor, -24))
        saveChangesButton.configureHeight(height: 55)
    }
    
    private func configureSaveChangesButton(for isEnabled: Bool) {
        saveChangesButton.isEnabled = isEnabled
        
        if isEnabled {
            saveChangesButton.backgroundColor = K.Styles.actionButtonColor
        } else {
            saveChangesButton.backgroundColor = .darkGray
        }
    }
}

// MARK: - Button Tapped
extension ProfileEditViewController {
    
    @objc
    private func editImageViewButtonTapped() {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = PHPickerFilter.images
        
        let pickerViewController = PHPickerViewController(configuration: config)
        pickerViewController.delegate = self
        
        progressView.isHidden    = true
        progressView.setProgress(0, animated: true)
        
        self.present(pickerViewController, animated: true)
    }
    
    @objc
    private func saveChangesButtonTapped() {
        guard let fullName       = editFullNameTextField.text,
              let username       = editUsernameTextField.text else { return }
        profileEditPresenter.updateUser(with: fullName,
                                        username: username)
    }
}

// MARK: UITextField Delegate
extension ProfileEditViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        if currentUsername != editUsernameTextField.text ||
           currentFullName != editFullNameTextField.text
        {
            configureSaveChangesButton(for: true)
        } else {
            configureSaveChangesButton(for: false)
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
                    DispatchQueue.main.async {
                        self.currentImageView.image = image
                        self.configureSaveChangesButton(for: false)
                    }
                    self.profileEditPresenter.uploadImage(image: imageData)
            }
        }
    }
}

// MARK: - Profile Edit Presenter Output
extension ProfileEditViewController: ProfileEditPresenterOutput {
    
    func showCurrentUser(currentUser: UserPresentation) {
        currentImageView.setImage(with: currentUser.profilePic ?? "")
        currentNameLabel.text      = currentUser.fullName
        currentEmailLabel.text     = currentUser.email
        
        editEmailTextField.text    = currentUser.email
        editFullNameTextField.text     = currentUser.fullName
        editUsernameTextField.text = currentUser.username
        
        currentUsername            = currentUser.username
        currentFullName            = currentUser.fullName
    }
    
    func initializeProgress(progress: Float?) {
        if let progress = progress {
            progressView.isHidden = false
            progressView.setProgress(progress / 100, animated: true)
        }
    }
    
    func showUpdatedImage(with url: String) {
        currentImageView.setImage(with: url)
        configureSaveChangesButton(for: true)
        progressView.isHidden = true
        progressView.setProgress(0, animated: true)
    }
    
    func showError(error: Error) {
        showErrorAlert(with: "Something went wrong",
                       message: error.localizedDescription,
                       buttonTitle: "OK")
    }
    
    func displayLoading() {
        configureSaveChangesButton(for: false)
        showLoadingView()
    }
    
    func dismissLoading() {
        dismissLoadingView()
        configureSaveChangesButton(for: true)
    }
}
