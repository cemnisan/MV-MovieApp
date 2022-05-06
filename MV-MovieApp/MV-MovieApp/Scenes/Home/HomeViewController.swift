//
//  HomeViewController.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 30.04.2022.
//

import UIKit
import MV_Components

final class HomeViewController: UIViewController {
    
    var homePresenter: HomePresenter!
    var user: UserPresentation!
    
    private let usernameLabel = MVSecondaryLabel(textAlignment: .left, fontSize: 24, textColor: .white, text: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        configure()
    }
}

// MARK: - Configure
extension HomeViewController {
    
    private func configure() {
        configureViewController()
        configureUsernameLabel()
    }
    
    private func configureViewController() {
        view.backgroundColor = K.Auth.backgroundColor
        title                = "Home"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = K.Auth.navTitleColor
    }
    
    private func configureUsernameLabel() {
        view.addSubview(usernameLabel)
        
        usernameLabel.text = "Welcome, \(user.username)"
        
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            usernameLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
}

// MARK: - HomeView Protocol
extension HomeViewController: HomeViewProtocol {
    func handleOutput(_ output: HomePresenterOutput) {}
}
