//
//  File.swift
//  
//
//  Created by Cem Nisan on 26.05.2022.
//

import UIKit

public final class MVBodyLabel: UILabel {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(textAlignment: NSTextAlignment, textColor: UIColor) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.textColor     = textColor
    }
}

extension MVBodyLabel {
    
    private func configure() {
        font                      = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor        = 0.75
        lineBreakMode             = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
