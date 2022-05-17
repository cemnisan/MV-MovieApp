//
//  File.swift
//  
//
//  Created by Cem Nisan on 1.05.2022.
//


import UIKit

public final class MVFormTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 5)
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(placeHolder: String) {
        self.init(frame: .zero)
        
        attributedPlaceholder = NSAttributedString(
            string: placeHolder,
            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
    }
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension MVFormTextField {
    
    private func configure() {
        layer.cornerRadius        = 10
        
        textColor                 = .white
        textAlignment             = .left
        font                      = UIFont.systemFont(ofSize: 16)
        adjustsFontSizeToFitWidth = true
        minimumFontSize           = 12
        
        backgroundColor           = #colorLiteral(red: 0.2076013088, green: 0.2020693719, blue: 0.2528569102, alpha: 1)
        autocorrectionType        = .no
        autocapitalizationType    = .none
        translatesAutoresizingMaskIntoConstraints = false
    }
}
