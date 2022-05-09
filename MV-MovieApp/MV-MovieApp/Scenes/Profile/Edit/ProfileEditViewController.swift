//
//  ProfileEditViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 9.05.2022.
//

import UIKit
import MV_Components

final class ProfileEditViewController: UIViewController {
    
    private let currentImageView      = MVUserImage(cornerRadius: 60)
    private let currentNameLabel      = MVTitleLabel(textAlignment: .center, fontSize: 24, textColor: .white)
    private let currentEmailLabel     = MVSecondaryLabel(textAlignment: .center, fontSize: 20, textColor: .systemGray, text: nil)
    
    private let editUsernameLabel     = MVSecondaryLabel(textAlignment: .left, fontSize: 17, textColor: .white, text: "Username")
    private let editUsernameTextField = MVAuthenticatesTextField(frame: .zero)
    
    private let editNameLabel         = MVSecondaryLabel(textAlignment: .left, fontSize: 17, textColor: .white, text: "Full Name")
    private let editNameTextField     = MVAuthenticatesTextField(frame: .zero)
     
    private let editEmailLabel        = MVSecondaryLabel(textAlignment: .left, fontSize: 17, textColor: .white, text: "Email")
    private let editEmailTextField    = MVAuthenticatesTextField(frame: .zero)
         
    private let saveChangesButton     = MVButton(backgroundColor: K.Styles.actionButtonColor, title: "Save Changes", cornerRadius: 20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

extension ProfileEditViewController {
    
    private func configure() {
        configureViewController()
        configureUserImage()
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
        currentImageView.image = #imageLiteral(resourceName: "profilePic")
        
        currentImageView.configureConstraints(top: (view.safeAreaLayoutGuide.topAnchor, 8),
                                           centerX: (view.centerXAnchor, 0))
        currentImageView.configureHeight(height: 120)
        currentImageView.configureWidth(width: 120)
    }
    
    private func configureUserNameLabel() {
        view.addSubview(currentNameLabel)
        currentNameLabel.text = "Cem Nisan"
        currentNameLabel.configureConstraints(top: (currentImageView.bottomAnchor, 16),
                                           leading: (view.leadingAnchor, 24),
                                           trailing: (view.trailingAnchor, -24))
        currentNameLabel.configureHeight(height: 25)
    }
    
    private func configureUserEmailLabel() {
        view.addSubview(currentEmailLabel)
        currentEmailLabel.text = "cnisanbusiness@gmail.com"
        
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
        
        editUsernameTextField.text = "cemnisan"
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
        
        editNameTextField.text = "Cem Nisan"
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
        
        editEmailTextField.text = "cnisanbusiness@gmail.com"
        editEmailTextField.configureConstraints(top: (editEmailLabel.bottomAnchor, 8))
        editEmailTextField.configureHeight(height: 40)
    }
    
    private func configureSaveChangesButton() {
        view.addSubview(saveChangesButton)
        
        saveChangesButton.configureConstraints(top: (editEmailTextField.bottomAnchor, 40),
                                               leading: (view.leadingAnchor, 24),
                                               trailing: (view.trailingAnchor, -24))
        saveChangesButton.configureHeight(height: 55)
    }
}
