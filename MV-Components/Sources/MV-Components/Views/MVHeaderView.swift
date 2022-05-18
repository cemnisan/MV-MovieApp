//
//  File.swift
//  
//
//  Created by Cem Nisan on 18.05.2022.
//

import UIKit

public final class MVHeaderView: UICollectionReusableView {
    public static let identifier = "header-reuse"
    
    public let label = UILabel()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MVHeaderView {
    
    private func configure() {
        backgroundColor = #colorLiteral(red: 0.1202597097, green: 0.1102947071, blue: 0.174954325, alpha: 1)
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .white
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
    }
}
