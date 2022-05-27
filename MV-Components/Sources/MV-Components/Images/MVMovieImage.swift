//
//  File.swift
//  
//
//  Created by Cem Nisan on 28.05.2022.
//

import UIKit

public final class MVMovieImage: UIImageView {
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MVMovieImage {
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds      = true
        contentMode        = .scaleToFill
        translatesAutoresizingMaskIntoConstraints = false
    }
}
