//
//  File.swift
//  
//
//  Created by Cem Nisan on 17.05.2022.
//

import UIKit

public final class MVFormStackView: UIStackView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(stackSpacing: CGFloat) {
        self.init(frame: .zero)
        
        spacing = stackSpacing
    }
}

extension MVFormStackView {
    
    private func configure() {
        distribution = .fillEqually
        axis         = .vertical
        translatesAutoresizingMaskIntoConstraints = false
    }
}
