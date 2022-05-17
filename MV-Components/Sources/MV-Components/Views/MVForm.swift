//
//  File.swift
//  
//
//  Created by Cem Nisan on 17.05.2022.
//

import UIKit

public final class MVForm: UIView {
    
    public let formLabel = MVSecondaryLabel(
        textAlignment: .left,
        fontSize: 17,
        textColor: .white,
        text: nil)
    public let formTextField = MVFormTextField(placeHolder: "Enter your info")
    
    var label: String!
    var placeHolder: String!
    var textFieldHeight: CGFloat!
    
    public init(frame: CGRect,
                label: String,
                placeHolder: String,
                height: CGFloat) {
        formLabel.text = label
        formTextField.placeholder = placeHolder
        textFieldHeight = height
        
        super.init(frame: frame)
        configureForm()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MVForm {
    
    private func configureForm() {
        [formLabel,
         formTextField
        ].forEach { addSubview($0) }
        
        NSLayoutConstraint.activate([
            formLabel.topAnchor.constraint(equalTo: topAnchor),
            formLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            formLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            formLabel.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            formTextField.topAnchor.constraint(equalTo: formLabel.bottomAnchor,
                                               constant: 8),
            formTextField.leadingAnchor.constraint(equalTo: leadingAnchor),
            formTextField.trailingAnchor.constraint(equalTo: trailingAnchor),
            formTextField.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
    }
}
