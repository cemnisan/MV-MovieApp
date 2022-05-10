//
//  File.swift
//  
//
//  Created by Cem Nisan on 8.05.2022.
//

import UIKit

public class MVAlertController: UIViewController {
    
    let containerView     = MVAlertContainerView(frame: .zero)
    let alertTitleLabel   = MVTitleLabel(textAlignment: .center, fontSize: 20, textColor: .label)
    let alertMessageLabel = MVSecondaryLabel(textAlignment: .center, fontSize: 17, textColor: .label, text: nil)
    let alertDoneButton   = MVButton(backgroundColor: #colorLiteral(red: 0.6673278213, green: 0.4603560567, blue: 0.3788063228, alpha: 1), title: nil, cornerRadius: 10)
    
    private var alertTitle: String?
    private var alertMessage: String?
    var alertButtonTitle: String?
    
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
    }
}

extension MVAlertController {

    @objc
    func configure() { }
    
    func configureViewController() {
        view.backgroundColor?.withAlphaComponent(0.75)
    }
    
    func configureContainerView() {
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 320),
            containerView.heightAnchor.constraint(equalToConstant: 260)
        ])
    }
    
    func configureAlertTitleLabel() {
        containerView.addSubview(alertTitleLabel)
        alertTitleLabel.text = alertTitle
        
        NSLayoutConstraint.activate([
            alertTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            alertTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            alertTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            alertTitleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureAlertMessageLabel() {
        containerView.addSubview(alertMessageLabel)
        alertMessageLabel.text          = alertMessage
        alertMessageLabel.numberOfLines = 3
        
        NSLayoutConstraint.activate([
            alertMessageLabel.topAnchor.constraint(equalTo: alertTitleLabel.bottomAnchor, constant: 8),
            alertMessageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            alertMessageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            alertMessageLabel.bottomAnchor.constraint(equalTo: alertDoneButton.topAnchor, constant: -8)
        ])
    }
    
    @objc
    // Override
    func configureAlertButton() {}
}

extension MVAlertController {
    
    @objc
    func dismissAlertViewController() {
        dismiss(animated: true)
    }
}
