//
//  File.swift
//  
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit

public class MVContainerView: UIView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(backgroundColor: UIColor) {
        self.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
    }
}

extension MVContainerView {
    
    private func configure() {
        layer.cornerRadius = 10
        translatesAutoresizingMaskIntoConstraints = false
    }
}
