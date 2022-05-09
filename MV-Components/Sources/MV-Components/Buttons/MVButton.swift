//
//  File.swift
//  
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit

public final class MVButton: UIButton {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(backgroundColor: UIColor,
                            title: String?, cornerRadius: CGFloat) {
        self.init(frame: .zero)
        
        setTitle(title, for: .normal)
        self.backgroundColor = backgroundColor
        layer.cornerRadius   = cornerRadius
    }
    
    public convenience init(image: UIImage) {
        self.init(frame: .zero)
        
        setBackgroundImage(image, for: .normal)
    }
}

extension MVButton {
    
    private func configure() {
        titleLabel?.font   = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
