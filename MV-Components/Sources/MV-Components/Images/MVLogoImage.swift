//
//  File.swift
//  
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit

public final class MVLogoImage: UIImageView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(image: UIImage, tintColor: UIColor) {
        self.init(frame: .zero)
        
        self.image     = image
        self.tintColor = tintColor
    }
}

extension MVLogoImage {
    
    private func configure() {
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
    }
}
