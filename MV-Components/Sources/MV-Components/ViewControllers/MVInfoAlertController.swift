//
//  File.swift
//  
//
//  Created by Cem Nisan on 10.05.2022.
//

import UIKit

public final class MVInfoAlertController: MVAlertController {
    
    public override init(alertTitle: String,
                         alertMessage: String,
                         alertButtonTitle: String) {
        super.init(alertTitle: alertTitle,
                   alertMessage: alertMessage,
                   alertButtonTitle: alertButtonTitle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        configure()
    }
    
    override func configure() {
         configureViewController()
         configureContainerView()
         configureAlertTitleLabel()
         configureAlertButton()
         configureAlertMessageLabel()
     }
    
    override func configureAlertButton() {
        containerView.addSubview(alertDoneButton)
        alertDoneButton.setTitle(alertButtonTitle, for: .normal)
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

// MARK: - Configure
extension MVInfoAlertController {}
