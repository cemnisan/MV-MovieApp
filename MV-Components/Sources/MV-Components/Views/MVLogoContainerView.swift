//
//  File.swift
//  
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit

public enum LogoType { case apple, google }

public final class MVLogoContainerView: UIView {
    
    private let logoImageView = MVButton(frame: .zero)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureLogoImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure
extension MVLogoContainerView {
    
    private func configureLogoImageView() {
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalToConstant: 24),
            logoImageView.heightAnchor.constraint(equalToConstant: 24),
            logoImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

extension MVLogoContainerView {
    
    public func set(type: LogoType) {
        switch type {
        case .apple:
            logoImageView.setImage(UIImage(named: "apple"), for: .normal)
        case .google:
            logoImageView.setImage(UIImage(named: "google"), for: .normal)
        }
    }
}
