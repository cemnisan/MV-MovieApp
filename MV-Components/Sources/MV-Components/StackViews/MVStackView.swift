//
//  File.swift
//  
//
//  Created by Cem Nisan on 28.05.2022.
//

import UIKit

public final class MVStackView: UIStackView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(spacing: CGFloat) {
        self.init(frame: .zero)
        
        self.spacing = spacing
    }
}

extension MVStackView {
    
    private func configure() {
        axis = .horizontal
        distribution = .equalSpacing
        translatesAutoresizingMaskIntoConstraints = false
    }
}
