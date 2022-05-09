//
//  File.swift
//  
//
//  Created by Cem Nisan on 9.05.2022.
//

import UIKit

public final class MVUserImage: UIImageView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(cornerRadius: CGFloat) {
        self.init(frame: .zero)
        
        layer.cornerRadius = cornerRadius
    }
}

extension MVUserImage {
    
    private func configure() {
        clipsToBounds      = true
        contentMode        = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }
}
