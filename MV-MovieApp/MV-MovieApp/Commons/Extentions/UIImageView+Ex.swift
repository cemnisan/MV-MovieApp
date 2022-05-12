//
//  UIImageView+Ex.swift
//  MV-MovieApp
//
//  Created by Cem Nisan on 11.05.2022.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    func setImage(with url: String) {
        guard let url = URL(string: url) else { return }
        
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }
}
