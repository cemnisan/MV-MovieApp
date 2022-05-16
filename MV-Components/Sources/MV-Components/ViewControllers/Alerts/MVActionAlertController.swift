//
//  File.swift
//  
//
//  Created by Cem Nisan on 10.05.2022.
//

import UIKit

public protocol MVActionAlertDelegate: AnyObject {
    func actionButtonTapped()
}

public final class MVActionAlertController: MVAlertController {
    
    public weak var delegate: MVActionAlertDelegate?
    
    private let alertActionButton = MVButton(backgroundColor: .systemRed, title: nil, cornerRadius: 10)
    private let alertDoneButtonTitle: String
    
    public init(alertTitle: String,
                alertMessage: String,
                alertCancelButton: String,
                alertDoneButtonTitle: String,
                delegate: MVActionAlertDelegate? = nil) {
        self.alertDoneButtonTitle = alertDoneButtonTitle
        self.delegate             = delegate
        super.init(alertTitle: alertTitle,
                   alertMessage: alertMessage,
                   alertButtonTitle: alertCancelButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
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
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(stackView)
        
        alertDoneButton.setTitle(alertButtonTitle, for: .normal)
        alertActionButton.setTitle(alertDoneButtonTitle, for: .normal)
        alertDoneButton.addTarget(self,
                                  action: #selector(dismissAlertViewController),
                                  for: .touchUpInside)
        alertActionButton.addTarget(self, action: #selector(actionButtonDidTapped), for: .touchUpInside)

        [alertDoneButton, alertActionButton].forEach { stackView.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

// MARK: - Button Tapped
extension MVActionAlertController {
    
    @objc
    private func actionButtonDidTapped() {
        delegate?.actionButtonTapped()
    }
}
