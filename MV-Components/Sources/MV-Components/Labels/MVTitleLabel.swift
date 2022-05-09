//
//  File.swift
//
//
//  Created by Cem Nisan on 1.05.2022.
//

import UIKit

public final class MVTitleLabel: UILabel {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(textAlignment: NSTextAlignment,
                     fontSize: CGFloat,
                     textColor: UIColor) {
        self.init(frame: .zero)
        
        self.textAlignment = textAlignment
        self.font          = UIFont.systemFont(ofSize: fontSize, weight: .bold)
        self.textColor     = textColor
    }
}

extension MVTitleLabel {
    
    private func configure() {
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.9
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
}
