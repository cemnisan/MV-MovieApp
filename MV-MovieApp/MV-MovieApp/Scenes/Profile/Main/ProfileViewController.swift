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
    private let settingsTableView = UITableView(frame: .zero, style: .grouped)
    
    var profilePresenter: ProfilePresenterProtocol!
    
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
        configureSettingsTableView()
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
        
        userImageView.configureConstraints(leading: (userContainerView.leadingAnchor, 16),
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
    
    private func configureSettingsTableView() {
        view.addSubview(settingsTableView)
        settingsTableView.register(SettingTableViewCell.self,
                                   forCellReuseIdentifier: SettingTableViewCell.identifier)
        settingsTableView.backgroundColor = K.Styles.backgroundColor
        settingsTableView.dataSource = self
        settingsTableView.delegate   = self
        settingsTableView.translatesAutoresizingMaskIntoConstraints = false
        settingsTableView.configureConstraints(top: (userContainerView.bottomAnchor, 8),
                                               leading: (view.leadingAnchor, 24),
                                               trailing: (view.trailingAnchor, -24),
                                               bottom: (view.bottomAnchor, -16))
    }
}

// MARK: - Button Tapped
extension ProfileViewController {
    
    @objc
    private func userDidTappedEditButton() {
        profilePresenter.selectEditButton()
    }
}

// MARK: - TableView Data Source
extension ProfileViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.settings.count
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return Section.settings[section].option.count
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        let setting = Section.settings[section]
        return setting.title
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplayHeaderView view: UIView,
                   forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.textLabel?.textColor = .white
            headerView.textLabel?.font      = UIFont.systemFont(ofSize: 17,
                                                                weight: .semibold)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: SettingTableViewCell.identifier,
            for: indexPath) as! SettingTableViewCell
        let setting = Section.settings[indexPath.section].option[indexPath.row]
        cell.set(with: setting)
        
        return cell
    }
}

// MARK: - TableView Delegate
extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        profilePresenter.selectSetting(at: indexPath.section, index: indexPath.row)
    }
}

extension ProfileViewController: ProfilePresenterOutput {}
