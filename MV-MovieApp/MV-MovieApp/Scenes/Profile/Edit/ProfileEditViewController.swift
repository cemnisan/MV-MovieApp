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
    
    private let currentImageView       = MVUserImage(cornerRadius: 60)
    private let editImageContainerView = MVContainerView(backgroundColor: K.Styles.backgroundColor)
    private let editImageButton        = MVButton(frame: .zero)
    
    private let currentNameLabel       = MVTitleLabel(textAlignment: .center, fontSize: 24, textColor: .white)
    private let currentEmailLabel      = MVSecondaryLabel(textAlignment: .center, fontSize: 20, textColor: .systemGray, text: nil)
     
    private let editUsernameLabel      = MVSecondaryLabel(textAlignment: .left, fontSize: 17, textColor: .white, text: "Username")
    private let editUsernameTextField  = MVAuthenticatesTextField(placeHolder: "Select a username")
     
    private let editNameLabel          = MVSecondaryLabel(textAlignment: .left, fontSize: 17, textColor: .white, text: "Full Name")
    private let editNameTextField      = MVAuthenticatesTextField(frame: .zero)
      
    private let editEmailLabel         = MVSecondaryLabel(textAlignment: .left, fontSize: 17, textColor: .white, text: "Email")
    private let editEmailTextField     = MVAuthenticatesTextField(frame: .zero)
          
    private let saveChangesButton      = MVButton(backgroundColor: K.Styles.actionButtonColor, title: "Save Changes", cornerRadius: 20)
    
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
        configureUserImage()
        configureEditImageContainerView()
        configureEditImageButton()
        configureUserNameLabel()
        configureUserEmailLabel()
        configureEditUsernameElements()
        configureEditNameElements()
        configureEditEmailElements()
        configureSaveChangesButton()
    }
    
    private func configureViewController() {
        title                = "Edit Profile"
        view.backgroundColor = K.Styles.backgroundColor
        navigationController?.navigationBar.tintColor = K.Styles.labelTextColor
    }
    
    private func configureUserImage() {
        view.addSubview(currentImageView)
        
        currentImageView.configureConstraints(top: (view.safeAreaLayoutGuide.topAnchor, 8),
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
        
        editUsernameTextField.configureConstraints(top: (editUsernameLabel.bottomAnchor, 8))
        editUsernameTextField.configureHeight(height: 40)
    }
    
    private func configureEditNameElements() {
        [editNameLabel,
         editNameTextField
        ].forEach {
            view.addSubview($0)
            $0.configureConstraints(leading: (view.leadingAnchor, 24),
                                    trailing: (view.trailingAnchor, -24))
        }
        editNameLabel.configureConstraints(top: (editUsernameTextField.bottomAnchor, 24))
        editNameLabel.configureHeight(height: 25)
        
        editNameTextField.configureConstraints(top: (editNameLabel.bottomAnchor, 8))
        editNameTextField.configureHeight(height: 40)
    }
    
    private func configureEditEmailElements() {
        [editEmailLabel,
         editEmailTextField
        ].forEach {
            view.addSubview($0)
            $0.configureConstraints(leading: (view.leadingAnchor, 24),
                                    trailing: (view.trailingAnchor, -24))
        }
        editEmailLabel.configureConstraints(top: (editNameTextField.bottomAnchor, 24))
        editEmailLabel.configureHeight(height: 25)
        
        editEmailTextField.configureConstraints(top: (editEmailLabel.bottomAnchor, 8))
        editEmailTextField.configureHeight(height: 40)
    }
    
    private func configureSaveChangesButton() {
        view.addSubview(saveChangesButton)
        
        saveChangesButton.addTarget(self,
                                    action: #selector(saveChangesButtonTapped),
                                    for: .touchUpInside)
        saveChangesButton.configureConstraints(top: (editEmailTextField.bottomAnchor, 40),
                                               leading: (view.leadingAnchor, 24),
                                               trailing: (view.trailingAnchor, -24))
        saveChangesButton.configureHeight(height: 55)
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
        self.present(pickerViewController, animated: true)
    }
    
    @objc
    private func saveChangesButtonTapped() {
        guard let imageData = currentImageView.image?.pngData() else { return }
        print(imageData)
        profileEditPresenter.updateUser(with: imageData, fullName: "Cem Nisan", username: "cameronhowe")
    }
}

extension ProfileEditViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController,
                didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                if let image = object as? UIImage {
                    guard let data = image.jpegData(compressionQuality: 1) else { return }
                    self.profileEditPresenter.uploadImage(image: data)
                }
            }
        }
    }
 }

// MARK: - Profile Edit Presenter Output
extension ProfileEditViewController: ProfileEditPresenterOutput {
    
    func showUpdatedImage(with url: URL) {
        currentImageView.setImage(with: url)
    }
    
    func displayLoading() {
        showLoadingView()
    }
    
    func dismissLoading() {
        dismissLoadingView()
    }
    
    func showCurrentUser(currentUser: UserPresentation) {
        currentNameLabel.text   = currentUser.username
        currentEmailLabel.text  = currentUser.email
        editEmailTextField.text = currentUser.email
        editNameTextField.text  = currentUser.username
        currentImageView.setImage(with: currentUser.imageURL)
    }
}
