//
//  File.swift
//  
//
//  Created by Cem Nisan on 8.05.2022.
//

import UIKit

public final class MVErrorAlertController: UIViewController {
    
    private let containerView     = MVAlertContainerView(frame: .zero)
    private let alertTitleLabel   = MVTitleLabel(textAlignment: .center, fontSize: 20, textColor: .label)
    private let alertMessageLabel = MVSecondaryLabel(textAlignment: .center, fontSize: 17, textColor: .label, text: nil)
    private let alertDoneButton   = MVButton(backgroundColor: #colorLiteral(red: 0.6673278213, green: 0.4603560567, blue: 0.3788063228, alpha: 1), title: nil)
    
    private var alertTitle: String?
    private var alertMessage: String?
    private var alertButtonTitle: String?
    
    public init(alertTitle: String,
                alertMessage: String,
                alertButtonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle       = alertTitle
        self.alertMessage     = alertMessage
        self.alertButtonTitle = alertButtonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
}

extension MVErrorAlertController {
    
    private func configure() {
        configureViewController()
        configureContainerView()
        configureAlertTitleLabel()
        configureAlertDoneButton()
        configureAlertMessageLabel()
    }
    
    private func configureViewController() {
        view.backgroundColor?.withAlphaComponent(0.75)
    }
    
    private func configureContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 320),
            containerView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
    
    private func configureAlertTitleLabel() {
        containerView.addSubview(alertTitleLabel)
        alertTitleLabel.text = alertTitle
        
        NSLayoutConstraint.activate([
            alertTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            alertTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            alertTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            alertTitleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureAlertMessageLabel() {
        containerView.addSubview(alertMessageLabel)
        alertMessageLabel.text = alertMessage
        
        NSLayoutConstraint.activate([
            alertMessageLabel.topAnchor.constraint(equalTo: alertTitleLabel.bottomAnchor, constant: 8),
            alertMessageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            alertMessageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            alertMessageLabel.bottomAnchor.constraint(equalTo: alertDoneButton.topAnchor, constant: -8)
        ])
    }
    
    private func configureAlertDoneButton() {
        containerView.addSubview(alertDoneButton)
        alertDoneButton.setTitle(alertButtonTitle,
                                 for: .normal)
        alertDoneButton.addTarget(self,
                                  action: #selector(dismissAlertViewController),
                                  for: .touchUpInside)
        NSLayoutConstraint.activate([
            alertDoneButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            alertDoneButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            alertDoneButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            alertDoneButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

extension MVErrorAlertController {
    
    @objc
    private func dismissAlertViewController() {
        dismiss(animated: true)
    }
}
