//
//  File.swift
//  
//
//  Created by Cem Nisan on 8.05.2022.
//

import UIKit

public final class MVLoadingIndicator: MVContainerView {
    
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let loadingLabel      = MVSecondaryLabel(textAlignment: .center, fontSize: 24, textColor: .white, text: "Loading...")
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MVLoadingIndicator {
    
    private func configure() {
        configureIndicatorView()
        configureLoadingLabel()
    }

    private func configureIndicatorView() {
        activityIndicator.color = .white
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
    
    private func configureLoadingLabel() {
        addSubview(loadingLabel)
        
        NSLayoutConstraint.activate([
            loadingLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            loadingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            loadingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            loadingLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
}

extension MVLoadingIndicator {
    
    public func startIndicatorView() {
        activityIndicator.startAnimating()
    }
    
    public func stopIndicatorView() {
        activityIndicator.stopAnimating()
    }
}
